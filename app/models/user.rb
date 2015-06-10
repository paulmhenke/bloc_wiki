class User < ActiveRecord::Base
  has_secure_password
  before_create :confirmation_token
  has_many :wikis
    
  validates_uniqueness_of :email 
  validates_format_of :email, :with => /@/
  validates :password, length: { minimum: 8 }
  
  after_initialize :set_role
  
  def admin?
    role == 'admin'
  end
  
  def standard?
    role == 'standard'
  end
  
  def premium?
    role == 'premium'
  end
  
  def set_role
    self.role ||= 'standard'
  end
  
  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end
  
  def send_password_reset
    
    self.password_reset_token = SecureRandom.urlsafe_base64.to_s
    self.password_reset_sent_at = Time.zone.now
    save!(validate: false)
    UserMailer.password_reset(self).deliver
  end
  
  private
  
  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
        
    
end
     
  
