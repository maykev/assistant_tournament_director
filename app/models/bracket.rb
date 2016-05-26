class Bracket
    def create(tournament_id)
        tournament = Tournament.find(tournament_id)

        # Randomly order players
        shuffled_players = tournament.players.shuffle(random: Random.new(Time.now.to_i))

        bracket_size = 2 ** Math.log2(shuffled_players.length).ceil
        bracket_positions = (1..bracket_size).to_a

        if shuffled_players.length == bracket_size
            byes = []
        else
            byes = tournament.bracket_configuration.bye_pattern[0..bracket_size - shuffled_players.length - 1]
        end

        winners_side = 1
        while winners_side <= (Math.log2(shuffled_players.length).ceil + 2) do
            match_count = 1
            while match_count <= [bracket_size / 2 ** winners_side, 1].max do
                match = Match.create!(status: :created, bracket_position: "W#{winners_side}-M#{match_count}", tournament: tournament)
                match_count = match_count + 1
            end

            winners_side = winners_side + 1
        end

        losers_side = 2
        while losers_side <= 2 * Math.log2(bracket_size) do
            match_count = 1
            while match_count <= [bracket_size / (2 ** ((losers_side / 2).floor + 1)), 1].max do
                match = Match.create!(status: :created, bracket_position: "L#{losers_side}-M#{match_count}", tournament: tournament)
                match_count = match_count + 1
            end

            losers_side = losers_side + 1
        end

        match_count = 1
        player_count = 0
        while match_count <= bracket_size / 2 do
            match = Match.where(bracket_position: "W1-M#{match_count}", tournament: tournament).first
            bye = false

            player_position = 2 * match_count - 1
            if byes.include?(player_position)
                bye = true
            else
                player = shuffled_players[player_count]
                player_count = player_count + 1
                match_player_1 = MatchPlayer.create!(match: match, player: player, position: 1, score: tournament.race - player.level.games_required)
            end

            player_position = 2 * match_count
            if byes.include?(player_position)
                bye = true
            else
                player = shuffled_players[player_count]
                player_count = player_count + 1
                match_player_2 = MatchPlayer.create!(match: match, player: player, position: 2, score: tournament.race - player.level.games_required)
            end

            if bye && match.match_players.length > 0
                match.update_attributes!(status: :finished)
            end

            match_count = match_count + 1
        end
    end

    def update(match_id)
        match = Match.includes(:match_players).find(match_id)

        bracket_size = 2 ** Math.log2(match.tournament.players.length).ceil
        winners_side = match.bracket_position.start_with?('W')
        match_number = match.bracket_position.slice!(match.bracket_position.index('M') + 1, match.bracket_position.length - 1).to_i
        round_number = match.bracket_position.slice!(1, match.bracket_position.index('-') - 1).to_i

        position = match_number % 2 == 0 ? 2 : 1

        return if match.match_players.empty?

        winner = match.match_players.order(score: :desc, position: :asc).first.player
        loser = match.match_players.order(score: :desc, position: :asc).last.player

        if winners_side
            winners_match = Match.where(bracket_position: "W#{round_number + 1}-M#{(match_number.to_f / 2.to_f).ceil}", tournament: match.tournament).first
            MatchPlayer.where(match: winners_match, position: position).destroy_all
            MatchPlayer.create!(match: winners_match, player: winner, position: position, score: winners_match.tournament.race - winner.level.games_required)

            if loser != winner && round_number + 1 != (Math.log2(match.tournament.players.length).ceil + 2)
                bracket_position = match.tournament.bracket_configuration.loser_position("W#{round_number}-M#{match_number}")

                losers_match = Match.where(bracket_position: bracket_position, tournament: match.tournament).first
                MatchPlayer.where(match: losers_match, position: (round_number == 1 ? position : 2)).destroy_all
                MatchPlayer.create!(match: losers_match, player: loser, position: (round_number == 1 ? position : 2), score: losers_match.tournament.race - loser.level.games_required)

                # Check for byes
                if round_number == 1
                    other_winners_match_number = match_number % 2 == 0 ? match_number - 1 : match_number + 1
                    other_winners_match = Match.where(bracket_position: "W1-M#{other_winners_match_number}", tournament: match.tournament).first
                    if other_winners_match.match_players.length < 2
                        losers_match.update_attributes!(status: :finished)
                    end
                elsif round_number == 2
                    losers_round_number = bracket_position.slice!(1, bracket_position.index('-') - 1).to_i
                    losers_match_number = bracket_position.slice!(bracket_position.index('M') + 1, bracket_position.length - 1).to_i
                    previous_losers_match = Match.where(bracket_position: "L#{losers_round_number - 1}-M#{losers_match_number}", tournament: match.tournament).first
                    if previous_losers_match.match_players.length == 0
                        losers_match.update_attributes!(status: :finished)
                    end
                end
            end
        else
            if round_number == (2 * Math.log2(bracket_size) - 1)
                final_round_number = Math.log2(match.tournament.players.length).ceil + 1
                winners_side_match = Match.where(bracket_position: "W#{final_round_number}-M1", tournament: match.tournament).first
                losers_side_match = Match.where(bracket_position: "L#{round_number + 1}-M1", tournament: match.tournament).first

                MatchPlayer.where(match: losers_side_match, position: 1).destroy_all
                MatchPlayer.where(match: winners_side_match, position: 2).destroy_all
                MatchPlayer.create!(match: losers_side_match, player: winner, position: 1, score: losers_side_match.tournament.race - winner.level.games_required)
                MatchPlayer.create!(match: winners_side_match, player: winner, position: 2, score: winners_side_match.tournament.race - winner.level.games_required)
            else
                losers_side_matches = (1..(bracket_size / (2 ** ((round_number / 2).floor + 1)))).to_a

                if round_number % 2 == 0
                    losers_side_match_number = losers_side_matches[match_number - 1]
                    position = 1
                else
                    losers_side_match_number = (match_number.to_f / 2.to_f).ceil
                end

                winners_match = Match.where(bracket_position: "L#{round_number + 1}-M#{losers_side_match_number}", tournament: match.tournament).first
                MatchPlayer.where(match: winners_match, position: position).destroy_all
                MatchPlayer.create!(match: winners_match, player: winner, position: position, score: winners_match.tournament.race - winner.level.games_required)
            end
        end
    end

    def add_player(tournament_id, player_id)
        tournament = Tournament.find(tournament_id)
        player = Player.find(player_id)

        # Determine position to add player
        bye_count = tournament.bracket_configuration.size - tournament.players.length - 1
        bracket_number = tournament.bracket_configuration.bye_pattern[bye_count]
        position = bracket_number % 2 == 0 ? 2 : 1

        # Find match for the position
        match_number = (bracket_number / 2).ceil
        match = Match.where(tournament: tournament, bracket_position: "W1-M#{match_number}").first

        # Update next match if it was a bye before adding new player
        match_player_count = match.match_players.length
        if match_player_count > 0
            Match.where(tournament: tournament, bracket_position: "W2-M#{(match_number.to_f / 2).ceil}").first.match_players.where(position: match_number % 2 == 0 ? 2 : 1).destroy_all
        end

        # Update loser side match in the case that someone got an automatic bye
        loser_side_match = Match.where(tournament: tournament, bracket_position: "L2-M#{(match_number.to_f / 2).ceil}").first
        if loser_side_match.match_players.length > 0
            Match.where(tournament: tournament, bracket_position: "L3-M#{(match_number.to_f / 2).ceil}").first.match_players.where(position: 1).destroy_all
        end

        # Create MatchPlayer for match at position
        MatchPlayer.create(player: player, match: match, score: tournament.race - player.level.games_required, position: position)

        # Update match if it is a bye
        if match_player_count == 0
            update(match.id)
        end

        # Add player to tournament
        PlayerTournament.create(tournament: tournament, player: player)
    end
end
