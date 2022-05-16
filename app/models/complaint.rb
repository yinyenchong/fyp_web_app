class Complaint < ApplicationRecord
  
  belongs_to :user, optional: false
  belongs_to :assignee, class_name: 'User', optional: false
  
  
  validates_presence_of :user_id
  #validates_presence_of :assignee_id
  validates_presence_of :title, presence: true
  validates_presence_of :body, presnece: true
  
  has_one_attached :complaintfile
  
  has_many :complaint_replies, dependent: :destroy
  has_many :assignees
  
  #after_create :escalate_to_executive_dean
  #after_save :escalate_to_executive_dean

  after_create :update_last_reply_at_during_complaint_creation
  
  
  scope :filter_by_assignee_id, ->(current_user) {
    
    
    where('assignee_id = ?', current_user)
    
    #where(:assignee_id => user_id)
    
    
    #where(
      
      #"id IN ( SELECT complaint_id 
      #"id IN ( SELECT id 
               #FROM complaints
               #WHERE user_id = ?
             #)", 
             
      #assignee_id
    #)
    
  
  }
  
  scope :filter_by_assignee_id_2, ->(user) { 
    
    where(id: Complaint.select(:complaint_id).where(user_id: user.id)) 
    
  }
  
  
  scope :in_progress, -> { 
    where(completed: false) 
    
  }
  
  
  scope :to_escalate, -> { 
    where('self.complaint_replies.last > ?', Time.new.utc)
  
  }
  
  
  scope :filter_by_staff, -> {
    
    where('!current_user.has_role? :student')
    
  }

  private
  
  
    def escalate_to_executive_dean
      #if self.updated_at = 
      
      #start_time = self.updated_at
      #end_time = DateTime.now
      
      #executive_deans = Role.find_by_name(:executive_dean).users
      
       #self.add_role(:student) if self.roles.blank?
      
      #if TimeDifference.between(start_time, end_time).in_minutes > 1
        #self.assignee_id = User.with_role :executive_dean
        #self.assignee_id = executive_deans
      #end
      
      
      
      start_time = self.complaint_replies.last.created_at
      end_time = DateTime.now
        
      executive_deans = Role.find_by_name(:executive_dean).users
        
      if TimeDifference.between(start_time, end_time).in_minutes > 1 and self.completed == false
            
        self.assignee_id = executive_deans
        
      end
      
    end
    
    def escalate_to_executive_dean_2
      
      start_time = self.last_reply_at
      end_time = DateTime.now
      
      executive_deans = Role.find_by_name(:executive_dean).users
      
      if TimeDifference.between(start_time, end_time).in_minutes > 1 and self.completed == false
            
        self.assignee_id = executive_deans
        
      end
      
    end
    
    
    def update_last_reply_at_during_complaint_creation
      
      self.touch(:last_reply_at) 
            
    end
  
  
  
  #delegate :name, :to => :user, :prefix => true
  #delegate :assignee_id, :to => :user, :prefix => true
  
  
  
end
