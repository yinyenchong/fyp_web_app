class StaticPagePolicy < ApplicationPolicy
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
  
  # _record in this example will just be :dashboard
  def initialize(user, _record)
    @user = user
  end  
  
  def home?
  end
  
  def complaints_charts?
    return true if user.blank? == false and !user.has_role? :student
  end 
  
end
