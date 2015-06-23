class RenameUserIdToOwnerIdOnWikis < ActiveRecord::Migration
  def change
    rename_column :wikis, :user_id, :owner_id
  end
end
