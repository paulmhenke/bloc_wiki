class User < ActiveRecord::Base
  has_secure_password
  before_create :confirmation_token
    
  validates_uniqueness_of :email 
  validates_format_of :email, :with => /@/
  validates :password, length: { minimum: 8 }
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end
  
  
  private
  
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
        
    
end
     
  
