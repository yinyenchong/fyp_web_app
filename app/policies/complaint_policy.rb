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
      return true if user.present? && user == complaint.user
    end
   
    def destroy?
      return true if user.present?  && user == complaint.user
    end
   
    private
   
      def complaint
        record
      end
      
  end
    
end