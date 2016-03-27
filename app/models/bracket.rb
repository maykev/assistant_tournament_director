class Bracket
    def create(tournament_id)
        tournament = Tournament.find(tournament_id)

        # Randomly order players
        shuffled_players = tournament.players.shuffle(random: Random.new(Time.now.to_i))

        bracket_size = 2 ** Math.log2(shuffled_players.length).ceil
        bracket_positions = (1..bracket_size).to_a
        byes = tournament.bye_pattern.split(',')[0..bracket_size - shuffled_players.length - 1].map(&:strip).map(&:to_i)

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
                update(match.id)
            end

            match_count = match_count + 1
        end
    end

    def update(match_id)
        match = Match.includes(:match_players).find(match_id)

        bracket_size = 2 ** Math.log2(match.tournament.players.length).ceil
        winners_side = match.bracket_position.start_with?('W')
        match_number = match.bracket_position[(match.bracket_position.index('M') + 1)..(match.bracket_position.length - 1)].to_i
        round_number = match.bracket_position[1..(match.bracket_position.index('-') - 1)].to_i

        puts match_number
        puts round_number

        position = match_number % 2 == 0 ? 2 : 1

        winner = match.match_players.order(score: :desc, position: :asc).first.player
        loser = match.match_players.order(score: :desc, position: :asc).last.player

        if winners_side
            winners_match = Match.where(bracket_position: "W#{round_number + 1}-M#{(match_number.to_f / 2.to_f).ceil}", tournament: match.tournament).first
            MatchPlayer.create!(match: winners_match, player: winner, position: position, score: winners_match.tournament.race - winner.level.games_required)

            if loser != winner && round_number + 1 != (Math.log2(match.tournament.players.length).ceil + 2)
                losers_side_round = [2 * round_number - 1, 2].max
                losers_side_matches = (1..(bracket_size / (2 ** ((losers_side_round / 2).floor + 1)))).to_a

                if losers_side_round == 2
                    losers_side_match_number = losers_side_matches[match_number / 2 - 1]
                else
                    if losers_side_round % 2 == 0
                        losers_side_match_number = losers_side_matches[match_number - 1]
                    else
                        losers_side_match_number = losers_side_matches[losers_side_matches.length - match_number]
                    end
                end

                losers_match = Match.where(bracket_position: "L#{losers_side_round}-M#{losers_side_match_number}", tournament: match.tournament).first
                MatchPlayer.create!(match: losers_match, player: loser, position: position, score: losers_match.tournament.race - loser.level.games_required)

                if round_number <= 2
                    previous_loser_match = Match.where(bracket_position: "L#{losers_side_round - 1}-M#{losers_side_match_number}", tournament: match.tournament).first
                    if previous_loser_match.nil?
                        previous_match_number = losers_side_match_number % 2 == 0 ? losers_side_match_number * 2 - 1 : losers_side_match_number * 2
                        previous_loser_match = Match.where(bracket_position: "W1-M#{previous_match_number}", tournament: match.tournament).first

                        if (previous_loser_match.match_players.length < 2)
                            update(losers_match)
                        end
                    elsif previous_loser_match.match_players.length == 0
                        update(losers_match)
                    end
                end
            end
        else
            if round_number == (2 * Math.log2(bracket_size) - 1)
                final_round_number = Math.log2(match.tournament.players.length).ceil + 1
                winners_side_match = Match.where(bracket_position: "W#{final_round_number}-M1", tournament: match.tournament).first
                losers_side_match = Match.where(bracket_position: "L#{round_number + 1}-M1", tournament: match.tournament).first
                MatchPlayer.create!(match: losers_side_match, player: winner, position: 1, score: losers_side_match.tournament.race - winner.level.games_required)
                MatchPlayer.create!(match: winners_side_match, player: winner, position: 2, score: winners_side_match.tournament.race - winner.level.games_required)
            else
                losers_side_matches = (1..(bracket_size / (2 ** ((round_number / 2).floor + 1)))).to_a

                if round_number % 2 == 0
                    losers_side_match_number = losers_side_matches[match_number - 1]
                else
                    losers_side_match_number = (match_number.to_f / 2.to_f).ceil
                end

                winners_match = Match.where(bracket_position: "L#{round_number + 1}-M#{losers_side_match_number}", tournament: match.tournament).first
                MatchPlayer.create!(match: winners_match, player: winner, position: position, score: winners_match.tournament.race - winner.level.games_required)
            end
        end
    end
end
