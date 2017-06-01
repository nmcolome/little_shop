class MakeItemColumnsNotNull < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :title, :string, null: false
    change_column :items, :description, :string, null: false
    change_column :items, :price, :decimal, null: false
  end
end
