class AddHasRowsToGames < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :has_min, :boolean, default: false
    add_column :games, :has_max, :boolean, default: false
  end
end
