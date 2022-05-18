require 'csv'

class Complaint < ApplicationRecord
  
  belongs_to :user, optional: false
  belongs_to :assignee, class_name: 'User', optional: false
  
  
  validates_presence_of :user_id
  validates_presence_of :assignee_id
  validates_presence_of :title, presence: true
  validates_presence_of :body, presnece: true
  
  has_one_attached :complaintfile
  
  has_many :complaint_replies, dependent: :destroy
  has_many :assignees
  has_many :escalated_to_users
  
  #after_create :escalate_to_executive_dean
  #after_save :escalate_to_executive_dean
  
  
  
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
  
  
  scope :filter_by_assignee_id_3, -> { 
    
    Complaint
      .select('*')
      .joins(:users)
      .where('complaints.created_at > ?', 1.day.ago)
  }
  
  
  scope :in_progress, -> { 
    where(completed: false) 
    
  }
  
  scope :filter_by_staff, -> {
    
    where('!current_user.has_role? :student')
    
  }

  private
  
  
    def escalate_to_executive_dean
      #if self.updated_at = 
      
      start_time = self.updated_at
      end_time = DateTime.now
      
      executive_deans = Role.find_by_name(:executive_dean).users
      
       #self.add_role(:student) if self.roles.blank?
      
      if TimeDifference.between(start_time, end_time).in_minutes > 1
        #self.assignee_id = User.with_role :executive_dean
        self.assignee_id = executive_deans
      end
    end
  
  def self.to_csv
    attributes = %w{id title user_id assignee_id created_at last_reply_at completed escalated completed_time}

    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |complaint|  
        # original method to grab all attributes regardless of formatting
        #csv << attributes.map{ |attr| complaint.send(attr) }
        
        csv << [complaint.id, complaint.title, complaint.user.name, complaint.assignee.name, 
                complaint.created_at, complaint.last_reply_at, complaint.completed, complaint.escalated, complaint.completed_time]
        
      end
      
      

        
     
    end
    
    
    #@complaints = Complaint.find(:all)
    
    #csv_string = CSV.generate do |csv|
    #CSV.generate do |csv|
      
         #csv << ["Complaint ID", "Submitter ID", "Submitter Name", "Title", "Assignee ID", "Assignee Name", "Completed Status", "Escalated Status", "Last Reply At", "Completed Time"]
        
         #all.each do |complaint|
           #csv << [self.id, self.user_id.name, self.title, self.assignee_id, self.assignee.name, self.completed, self.escalated, self.last_reply_at, self.completed_time]
         #end
    #end 
    
   
    
    
  end
  
  

  
  
  #delegate :name, :to => :user, :prefix => true
  #delegate :assignee_id, :to => :user, :prefix => true
  
  
  
end
