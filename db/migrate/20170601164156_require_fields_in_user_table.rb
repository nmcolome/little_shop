class RequireFieldsInUserTable < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :username, :string, null: false, unique: true
    change_column :users, :email, :string, null: false, unique: true
    change_column :users, :first_name, :string, null: false
    change_column :users, :last_name, :string, null: false
    change_column :users, :address, :string, null: false
    change_column :users, :city, :string, null: false
    change_column :users, :state, :string, null: false
    change_column :users, :zipcode, :string, null: false
  end
end
