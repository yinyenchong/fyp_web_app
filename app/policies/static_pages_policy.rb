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
  
  def home?
    true
  end
  
  def complaints_charts?
    return true if user.has_role? :admin
  end
  
end
