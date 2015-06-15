class AddSubscriptionIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscription_id, :string
    add_index :users, :subscription_id
  end
end
