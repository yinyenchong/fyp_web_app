class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    
    #def initialize(user)
      #@user = user
    #end
    
    def resolve
      
      #if user.has_role? :admin
        scope.all
      #end
      
      #if @user.has_role? :admin
      #if current_user.role == :admin
        #scope.all
      #end
    end
  end
    
  def index?
    #true
    #return true if user.present? && user.role == :admin
    return true if user.has_role? :admin
  end
  
  def create?
    return true if user.has_role? :admin
  end
  
  def show?
    return true if user.has_role? :admin or user.id == record.id
  end
  
  def edit?
    #true
    update?
    #current_user.has_role? :admin 
  end
  
  def update?
    #true
    #@user.has_role? :admin
    #return true if user.present? && current_user.has_role? :admin
    #current_user.has_role? :admin 
    return true if user.has_role? :admin or user.id == record.id
  end
  
  def destroy?
    return true if user.has_role? :admin
  end
  
  
end
