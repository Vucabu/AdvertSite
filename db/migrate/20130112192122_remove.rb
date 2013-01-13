class Remove < ActiveRecord::Migration
  def up
    remove_column :adverts, :picture
  end

  def down
    add_column :adverts, :picture, :string
  end
end
