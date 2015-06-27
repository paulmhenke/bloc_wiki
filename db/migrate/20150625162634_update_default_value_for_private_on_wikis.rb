class UpdateDefaultValueForPrivateOnWikis < ActiveRecord::Migration
  def change
    change_column(:wikis, :private, :boolean, default: false)
    Wiki.where(private: nil).update_all(private: false)
  end
end
