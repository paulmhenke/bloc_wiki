class AddCustomerIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :customer_id, :string
    add_index :users, :customer_id
  end
end
