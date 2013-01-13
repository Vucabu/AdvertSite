class AddIndexToAdvertsUserIdAndCreatedId < ActiveRecord::Migration
  def change
    add_index :adverts, [:user_id, :created_at]
  end
end
