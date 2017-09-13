class ThisBetterSolveThatProblem < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :min, :integer
    add_column :games, :max, :integer
  end
end
