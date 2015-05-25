class User < ActiveRecord::Base
    has_secure_password
    
  validates_uniqueness_of :email 
  validates_format_of :email, :with => /@/
  validates :password, length: { minimum: 8 }
    
end
     
  
