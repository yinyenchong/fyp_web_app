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
            
            executive_deans =  where(id: User.with_role(:executive_dean).ids)
            
            if TimeDifference.between(start_time, end_time).in_minutes > 1
                #self.assignee_id = User.with_role :executive_dean
                complaint.assignee_id = executive_deans
            end
            
        end
        
        
        def update_last_reply_at
      
            self.complaint.touch(:last_reply_at) if self.complaint
            
        end
        
        
        def export_to_csv
            csv_string = CSV.generate do |csv|
            
                csv << ["Complaint ID", "Submitter ID", "Submitter Name", "Title", "Assignee ID", "Assignee Name", "Completed Status", "Escalated Status", "Last Reply At", "Completed Time"]
                
                all.each do |complaint|
                    csv << [self.id, self.user_id.name, self.title, self.assignee_id, self.assignee.name, self.completed, self.escalated, self.last_reply_at, self.completed_time]
                end
         
            end     
            
            send_data csv_string,
           :type => 'text/csv; header=present',
           :disposition => "attachment; filename=complaints.csv" 
            
        end
    
end
