class AddAttachmentImageToAdverts < ActiveRecord::Migration
  def self.up
    change_table :adverts do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :adverts, :image
  end
end
