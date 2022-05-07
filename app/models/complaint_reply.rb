class ComplaintReply < ApplicationRecord
    
    validates_presence_of :user_id
    
    belongs_to :user
    belongs_to :complaint
    
end
