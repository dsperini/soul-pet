class AddOngNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :ong_name, :string
  end
end
