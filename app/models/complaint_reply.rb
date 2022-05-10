class ComplaintReply < ApplicationRecord
    
    validates_presence_of :user_id
    validates_presence_of :reply
    
    belongs_to :user
    belongs_to :complaint
    
    after_touch :escalate_to_executive_dean_by_reply
    
    
    
    
    private
    
        def escalate_to_executive_dean_by_reply
            
            start_time = ComplaintReply.last.updated_at
            end_time = DateTime.now
            
            executive_deans =  where(id: User.with_role(:executive_dean).ids)
            
            if TimeDifference.between(start_time, end_time).in_minutes > 1
                #self.assignee_id = User.with_role :executive_dean
                complaint.assignee_id = executive_deans
            end
            
        end
    
end
