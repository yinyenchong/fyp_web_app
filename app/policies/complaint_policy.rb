class ComplaintPolicy < ApplicationPolicy
  
  class Scope < Scope
  
    #def resolve
      
      #if @user.has_role? :admin
        #scope.all
      #else
        #scope.where(@user == complaint.user)
      #end
      
      #scope.all
      
    #end
    
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
  
  
    def index?
      user.has_role? :admin
    end
   
    def create?
      user.present?
    end
    
    def show?
      user.present?
    end
   
    def update?
      return true if user.has_role? :admin or user == complaint.user
    end
   
    def destroy?
      return true if user.has_role? :admin
    end
   
    private
   
      def complaint
        record
      end
      
    
end