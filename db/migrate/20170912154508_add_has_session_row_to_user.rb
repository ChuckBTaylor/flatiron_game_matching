class AddHasSessionRowToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :in_session, :boolean, default: false
  end
end
