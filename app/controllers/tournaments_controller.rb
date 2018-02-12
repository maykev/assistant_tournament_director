class TournamentsController < ApplicationController
    def index
        tournament = Tournament.includes(:bracket_configuration).where(status: :in_progress).where.not('bracket_configurations.id' => nil).last

        if tournament.present?
            redirect_to tournament_path(tournament.id)
        else
            render :index
        end
    end

    def show
        tournament = Tournament.find(params[:id])

        return head :not_found unless tournament.full?

        bracket_size = tournament.bracket_configuration.size
        winner_rounds = Math.log2(bracket_size) + 2;
        loser_rounds = (Math.log2(bracket_size) + 1) * 2 - 2;
        number_of_rounds = winner_rounds + loser_rounds;
        height = (bracket_size / 2 * 90 + 10).ceil

        @bracket = {
            width: ((number_of_rounds - 1) * 240 - 10).ceil,
            height: height,
            slots: []
        }

        tournament.matches.order(bracket_position: :asc).each do |match|
            match_players = match.match_players.order(position: :asc)

            if match_players.size < 2 then
                position_elements = match.bracket_position.split('-')
                round = position_elements[0].slice(1, position_elements[0].length - 1).to_i
                winners_side = position_elements[0].start_with?('W')

                if !winners_side && loser_rounds === round || winners_side && winner_rounds === round then
                    fake_match_player = MatchPlayer.new()
                    fake_match_player.position = 1
                    fake_match_player.score = nil
                    match_players.push(fake_match_player)
                else
                    # Figure out which one is missing and fake it
                    if match_players.size === 1 then
                        position = match_players.first.position === 1 ? 2 : 1
                        fake_match_player = MatchPlayer.new()
                        fake_match_player.position = position
                        fake_match_player.score = nil
                        match_players.push(fake_match_player)
                    else
                        fake_match_player1 = MatchPlayer.new()
                        fake_match_player1.position = 1
                        fake_match_player1.score = nil
                        match_players.push(fake_match_player1)
                        fake_match_player2 = MatchPlayer.new()
                        fake_match_player2.position = 2
                        fake_match_player2.score = nil
                        match_players.push(fake_match_player2)
                    end
                end
            end

            match_players.each do |match_player|
                position = "#{match.bracket_position}-P#{match_player.position}"
                position_elements = position.split('-')
                winners_side = position_elements[0].start_with?('W')
                round = position_elements[0].slice(1, position_elements[0].length - 1).to_i
                match_number = position_elements[1].slice(1, position_elements[1].length - 1).to_i
                player = position_elements[2].slice(1, position_elements[2].length - 1).to_i

                x = 0
                y = 0
                winner_line = ""
                loser_line = ""
                match_id = {}
                finish = ""
                multi_finish = {}
                letters = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']

                if winners_side then
                    x = loser_rounds * 240 + (round - 2) * 240

                	if player === 1 then
                        if round === 1 then
                            number = match_number * 2 - 1
                        else
                            match_id[:label] = "#{letters[round - 2]}#{match_number}"
                            match_id[:x] = x + 95
                        end

                		case round
                        when 1
                            y = 0 + (match_number - 1) * 90
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"
                        when 2
                            y = 20 + (match_number - 1) * 180
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 50} #{x + 250},#{y + 50}"
                            match_id[:y] = y + 55
                        when 3
                            y = 65 + (match_number - 1) * 360
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 95} #{x + 250},#{y + 95}"
                            match_id[:y] = y + 95
                        when 4
                            y = 150 + (match_number - 1) * 720
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 180} #{x + 250},#{y + 180}"
                            match_id[:y] = y + 185
                        when 5
                            y = 325 + (match_number - 1) * 1440
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 365} #{x + 250},#{y + 365}"
                            match_id[:y] = y + 370
                        when 6
                            if bracket_size === 32 then
                                y = 685
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                            else
                                y = 685 + (match_number - 1) * 2880
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 745} #{x + 250},#{y + 745}"
                                match_id[:y] = y + 750
                            end
                        when 7
                            if bracket_size === 32 then
                                match_player.score = ''
                                y = 705
                                winner_line = ""
                            else
                                y = 1425 + (match_number - 1) * 5760
                                if bracket_size === 64 then
                                    winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                                else
                                    winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 1445} #{x + 250},#{y + 1445}"
                                    match_id[:y] = y + 1450
                                end
                            end
                        when 8
                            if bracket_size === 64 then
                                match_player.score = ''
                                y = 1445
                                winner_line = ""
                            else
                                y = 2865 + (match_number - 1) * 11520
                                if bracket_size === 128 then
                                    winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                                else
                                    winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 2885} #{x + 250},#{y + 2885}"
                                    match_id[:y] = y + 2890
                                end
                            end
                        when 9
                            if bracket_size === 128 then
                                match_player.score = ''
                                y = 2885
                                winner_line = ""
                            else
                                y = 5745 + (match_number - 1) * 23040
                                if bracket_size === 256 then
                                    winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                                    finish = "2nd"
                                    match_id[:label] = "Winner of loser's bracket"
                                    match_id[:x] = x + 30
                                    match_id[:y] = y + 80
                                else
                                    winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                                end
                            end
                        when 10
                            if bracket_size === 256 then
                                match_player.score = ''
                                y = 5765
                                winner_line = ""
                                finish = "1st"
                            else
                                y = 5745 + (match_number - 1) * 46080
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y + 25} #{x + 250},#{y + 25}"
                            end
                        end
                	else
                        if round === 1 then
                            number = match_number * 2
                        end

                        case round
                        when 1
                            y = 40 + (match_number - 1) * 90
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 15} #{x + 150},#{y - 15}"
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 2
                            y = 110 + (match_number - 1) * 180
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 40} #{x + 250},#{y - 40}"
                        when 3
                            y = 245 + (match_number - 1) * 360
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 85} #{x + 250},#{y - 85}"
                        when 4
                            y = 515 + (match_number - 1) * 720
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 185} #{x + 250},#{y - 185}"
                        when 5
                            y = 1045 + (match_number - 1) * 1440
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 355} #{x + 250},#{y - 355}"
                        when 6
                            if bracket_size === 32 then
                                y = 725
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 15} #{x + 250},#{y - 15}"
                            else
                                y = 2125 + (match_number - 1) * 2880
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 695} #{x + 250},#{y - 695}"
                            end
                        when 7
                            if bracket_size === 64 then
                                match_player.score = ''
                                y = 1465
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 15} #{x + 250},#{y - 15}"
                            else
                                y = 4305 + (match_number - 1) * 5760
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 1435} #{x + 250},#{y - 1435}"
                            end
                        when 8
                            if bracket_size === 128 then
                                match_player.score = ''
                                y = 2905
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 15} #{x + 250},#{y - 15}"
                            else
                                y = 8625 + (match_number - 1)
                                winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 2875} #{x + 250},#{y - 2875}"
                            end
                        when 9
                            y = 5785 + (match_number - 1)
                            winner_line = "#{x + 210},#{y + 5} #{x + 230},#{y + 5} #{x + 230},#{y - 15} #{x + 250},#{y - 15}"
                        end
                	end
                else
                    # Loser side
                    if (round === loser_rounds) then
                    	x = 0
                    else
                    	x = ((loser_rounds - round) * 240).ceil
                    end

                	if player === 1 then
                        if round === 1 then
                            number = match_number * 2 - 1
                        end

                        # finishes
                        multi_finish = {
                            y: height / 2 + loser_rounds * 5
                        }

                        case loser_rounds.to_i - round.to_i
                        when 2
                            multi_finish[:label] = "4th"
                        when 3
                            multi_finish[:label] = "5 - 6th"
                        when 4
                            multi_finish[:label] = "7 - 8th"
                        when 5
                            multi_finish[:label] = "9 - 12th"
                        when 6
                            if bracket_size > 32 then
                                multi_finish[:label] = "13 - 16th"
                            end
                        when 7
                            if bracket_size > 64 then
                                multi_finish[:label] = "17 - 24th"
                            end
                        when 8
                            if bracket_size > 128 then
                                multi_finish[:label] = "25 - 32nd"
                            end
                        end

                		case round
                        when 2
                            y = 20 + (match_number - 1) * 180
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 50} #{x - 30},#{y + 50}"
                        when 3
                            y = 65 + (match_number - 1) * 180
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"
                            match_id[:label] = "Loser #{letters[round - 3]}#{bracket_size / 4 - match_number + 1}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80
                        when 4
                            y = 85 + (match_number - 1) * 360
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 95} #{x - 30},#{y + 95}"
                        when 5
                            y = 175 + (match_number - 1) * 360
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"

                            if match_number <= (bracket_size / 8) / 2
                                loser_number = bracket_size / 16 - match_number + 1
                            else
                                loser_number = bracket_size / 8 + (bracket_size / 16 - match_number + 1)
                            end
                            match_id[:label] = "Loser #{letters[round - 4]}#{loser_number}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80
                        when 6
                            y = 195 + (match_number - 1) * 720
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 185} #{x - 30},#{y + 185}"
                        when 7
                            y = 375 + (match_number - 1) * 720
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"

                            if match_number <= (bracket_size / 16) / 2
                                loser_number = bracket_size / 16 - (bracket_size / 32 - match_number)
                            else
                                loser_number = match_number - (bracket_size / 32)
                            end
                            match_id[:label] = "Loser #{letters[round - 5]}#{loser_number}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80
                        when 8
                            y = 395 + (match_number - 1) * 1440
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 365} #{x - 30},#{y + 365}"
                        when 9
                            y = 755 + (match_number - 1) * 1440
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"
                            match_id[:label] = "Loser #{letters[round - 6]}#{match_number}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80
                        when 10
                            if bracket_size === 32 then
                                match_player.score = ''
                                y = 775 + (match_number - 1) * 1440
                                loser_line = ""
                            else
                                y = 775 + (match_number - 1) * 2880
                                loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 735} #{x - 30},#{y + 735}"
                            end
                        when 11
                            y = 1505 + (match_number - 1) * 2880
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"
                            match_id[:label] = "Loser #{letters[round - 7]}#{bracket_size / 64 - match_number + 1}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80
                        when 12
                            if bracket_size === 64 then
                                y = 1525 + (match_number - 1) * 2880
                                loser_line = ""
                            else
                                y = 1525 + (match_number - 1) * 5760
                                loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 1425} #{x - 30},#{y + 1425}"
                            end
                        when 13
                            y = 2945 + (match_number - 1) * 5760
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"
                            match_id[:label] = "Loser #{letters[round - 8]}#{match_number}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80
                        when 14
                            if bracket_size === 128 then
                                y = 2965 + (match_number - 1) * 5760
                                loser_line = ""
                            else
                                y = 2965 + (match_number - 1) * 11520
                                loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 2875} #{x - 30},#{y + 2875}"
                            end
                        when 15
                            y = 5835 + (match_number - 1) * 11520
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 25} #{x - 30},#{y + 25}"
                            match_id[:label] = "Loser #{letters[round - 9]}#{match_number}"
                            match_id[:x] = x + 75
                            match_id[:y] = y + 80

                            if bracket_size === 256 then
                                finish = "3rd"
                            end
                        when 16
                            if bracket_size === 256 then
                                y = 5855 + (match_number - 1) * 11520
                                loser_line = ""
                                match_id[:label] = "To Finals"
                                match_id[:x] = x + 75
                                match_id[:y] = y + 40
                            else
                                y = 2965 + (match_number - 1) * 23040
                                loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y + 5900} #{x - 30},#{y + 5900}"
                            end
                        end
                	else
                        if round === 1 then
                            number = match_number * 2
                        end

                        case round
                        when 2
                            y = 110 + (match_number - 1) * 180
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 40} #{x - 30},#{y - 40}"
                        when 3
                            y = 105 + (match_number - 1) * 180
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 4
                            y = 265 + (match_number - 1) * 360
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 85} #{x - 30},#{y - 85}"
                        when 5
                            y = 215 + (match_number - 1) * 360
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 6
                            y = 555 + (match_number - 1) * 720
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 175} #{x - 30},#{y - 175}"
                        when 7
                            y = 415 + (match_number - 1) * 720
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 8
                            y = 1115 + (match_number - 1) * 1440
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 355} #{x - 30},#{y - 355}"
                        when 9
                            y = 795 + (match_number - 1) * 1440
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 10
                            y = 2215 + (match_number - 1) * 2880
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 705} #{x - 30},#{y - 705}"
                        when 11
                            y = 1545 + (match_number - 1) * 2880
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 12
                            y = 4405 + (match_number - 1) * 5760
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 1455} #{x - 30},#{y - 1455}"
                        when 13
                            y = 2985 + (match_number - 1) * 5760
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        when 14
                            y = 8725 + (match_number - 1) * 11520
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 2885} #{x - 30},#{y - 2885}"
                        when 15
                            y = 5875 + (match_number - 1) * 11520
                            loser_line = "#{x + 10},#{y + 5} #{x - 10},#{y + 5} #{x - 10},#{y - 15} #{x - 30},#{y - 15}"
                        end
                	end
                end

                @bracket[:slots].push({
                    number: number,
                    winner_line: winner_line,
                    loser_line: loser_line,
                    position: position,
                    finish: finish,
                    multi_finish: multi_finish,
                    x: x,
                    y: y,
                    match_number: 1,
                    match_id: match_id,
                    name: match_player.player.try(:full_name),
                    score: match_player.score,
                    level: match_player.player.try(:level).try(:name).try(:downcase)
                })
            end
        end

        render :index
    rescue ActiveRecord::RecordNotFound
        return head :not_found
    end

    def players
        @players = Tournament.find(params[:id]).players.order(:first_name, :last_name)
        render 'tournament_players'
    end
end
