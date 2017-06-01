class AddDefaultValueToStatus < ActiveRecord::Migration[5.0]
  def change
    change_column :items, :status, :integer, :default => 0
  end
end
