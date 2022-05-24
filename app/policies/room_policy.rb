class RoomPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    
    def resolve
      
      if user.has_role? :admin
        scope.all
      end

    end
  end
  
  # methods have to be under the Policy class, not Scope class
  
  def index?
    #true
    #return true if user.present? && user.role == :admin
    return true if !user.has_role? :student
  end
  
  def create?
    return true if !user.has_role? :student
  end
  
  def show?
    return true if !user.has_role? :student
  end
  
  def edit?
    #true
    update?
    #current_user.has_role? :admin 
  end
  
  def update?
    return true if !user.has_role? :student or user.id == record.id
  end
  
  def destroy?
    return true if !user.has_role? :student
  end
  
  
end
