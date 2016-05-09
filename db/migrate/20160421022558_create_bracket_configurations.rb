class CreateBracketConfigurations < ActiveRecord::Migration
    def change
        create_table :bracket_configurations do |t|
            t.integer :size, null: false
            t.text :bye_pattern
            t.text :loser_pattern
        end

        add_reference :tournaments, :bracket_configuration, index: true
    end
end
