class WikiPolicy < ApplicationPolicy

  def show?
      (user.admin?) || (user.premium? && (record.public? || record.owner == user || record.users.include?(user))) || (user.standard? && (record.public? || record.users.include?(user)))
  end
  
  def update?
    show?
  end

  def edit?
    show?
  end
      
end