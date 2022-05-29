class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    
    def resolve
      
      if user.has_role? :admin
        scope.all
      end
      
      #if @user.has_role? :admin
      #if current_user.role == :admin
        #scope.all
      #end
    end
  end
  
  # methods have to be under the Policy class, not Scope class
  
  def index?
    #true
    #return true if user.present? && user.role == :admin
    return true if user.has_role? :admin
  end
  
  def create?
    return true if user.has_role? :admin
  end
  
  def show?
    #return true 
    #return true if !user.has_role? :student and !(user.id == record.id)
    return true if !user.has_role? :student and !(user.id == record.id) 
  end
  
  def show_profile?
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