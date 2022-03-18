class AddColourToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :colour, :string
  end
end
