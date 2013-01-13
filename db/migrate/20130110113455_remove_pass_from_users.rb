class RemovePassFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :pass
  end

  def down
    add_column :users, :pass, :string
  end
end
