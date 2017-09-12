class CreateGamesTable < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :min
      t.integer :max
      t.integer :user_id
      t.string :quick_description
    end
  end
end
