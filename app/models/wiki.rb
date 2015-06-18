class Wiki < ActiveRecord::Base
  belongs_to :user
  
  scope :visible_to, -> (user) { user && user.standard? ? where(private: false) : where(private: false) && where(user_id: user.id) }
  #scope :visible_to, -> (user) { user  && user.premium? ? all : where(private: false) }
end
