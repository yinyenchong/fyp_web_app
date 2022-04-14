class ComplaintPolicy < ApplicationPolicy
  def index?
    true
  end
 
  def create?
    user.present?
  end
  
  def show?
    user.present?
  end
 
  def update?
    return true if user.present? 
  end
 
  def destroy?
    return true if user.present?
  end
 
  private
 
    def complaint
      record
    end
end