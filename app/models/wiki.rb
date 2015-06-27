class Wiki < ActiveRecord::Base
  belongs_to :owner, class_name: "User"
  has_many :collaborations
  has_many :users, through: :collaborations
  
  #scope :visible_to, -> (user) { user && user.standard? ? where(private: false) : where(private: false) && where(user_id: user.id) }
  # return wikis that are public OR wikis that are private and belong to the user
  scope :visible_to_premium, -> (user) { where("private = ? OR (owner_id = ? AND private = ?)", false, user.id, true) }
  scope :visible_to_standard, -> { where(private: false) }
  
  def self.visible_to(user)
    case user.role
    when "admin"
      all
    when "premium"
      visible_to_premium(user)
    when "standard"
      visible_to_standard
    end
  end
  
  def public?
    !private?
  end
  
  
end
