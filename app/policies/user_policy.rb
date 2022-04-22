class UserPolicy < ApplicationPolicy
    
  def index?
    user.present? 
  end
 
  def create?
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
 
    def user
      record
    end
end