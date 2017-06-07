class AddImageToItems < ActiveRecord::Migration[5.0]
  def self.up
    change_table :items do |t|
      t.attachment :image_att
    end
  end

  def self.down
    remove_attachment :items, :image_att
  end

end
