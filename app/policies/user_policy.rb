class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    
    
    def resolve
      scope.all
    end
    
    def index?
      #@user.has_role? :admin 
      true
    end
    
    def create?
      true
    end
    
    def edit?
      true
    end
    
    def update?
      #@user.has_role? :admin
      true
    end
    
    def destroy?
      true
    end
    
  end
end
