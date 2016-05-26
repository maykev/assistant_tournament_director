class BracketConfiguration < ActiveRecord::Base
    serialize :bye_pattern, Array
    serialize :loser_pattern, Array

    def loser_position(winner_position)
        bracket_positions = loser_pattern.select { |pattern| pattern.split('->').first == winner_position }
        bracket_positions.first.split('->').last
    end
end
