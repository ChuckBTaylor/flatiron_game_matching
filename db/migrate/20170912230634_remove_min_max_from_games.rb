class RemoveMinMaxFromGames < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :has_min, :integer
    remove_column :games, :has_max, :integer
  end
end
