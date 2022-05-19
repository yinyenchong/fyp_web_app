class ComplaintReply < ApplicationRecord
    
    validates_presence_of :user_id
    validates_presence_of :reply
    
    belongs_to :user
    belongs_to :complaint
    
    after_touch :escalate_to_executive_dean_by_reply
    
    after_save_commit do
        
        
        # this will update the last_updated column in Complaints table as well (must not have the same function active in comaplaint.rb)
        update_last_reply_at
  
    end
    
    private
    
        def escalate_to_executive_dean_by_reply
            
            start_time = ComplaintReply.last.updated_at
            end_time = DateTime.now
            
            executive_deans = Role.find_by_name(:executive_dean).users
            
            if TimeDifference.between(start_time, end_time).in_minutes > 1
                #self.assignee_id = User.with_role :executive_dean
                complaint.assignee_id = executive_deans
            end
            
        end
        
        
        def update_last_reply_at
      
            self.complaint.touch(:last_reply_at) if self.complaint
            
        end
        
    
end
