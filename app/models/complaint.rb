require 'csv'

class Complaint < ApplicationRecord
  
  belongs_to :user, optional: false
  belongs_to :assignee, class_name: 'User', optional: false
  belongs_to :escalated_to_user, class_name: 'User', optional: true
  
  
  validates_presence_of :user_id
  validates_presence_of :assignee_id
  validates_presence_of :title, presence: true
  validates_presence_of :body, presnece: true
  
  has_one_attached :complaintfile
  
  has_many :complaint_replies, dependent: :destroy
  has_many :assignees
  has_many :escalated_to_users
  

  # this works when not being run as a job
  before_commit :escalate_to_executive_dean!
  
  
  scope :filter_by_assignee_id, ->(current_user) {
    
    where('assignee_id = ?', current_user)
    
    #where(:assignee_id => user_id)
  
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
  
  def escalate_to_executive_dean!
    
    start_time = self.created_at
    end_time = DateTime.now
    
    #executive_deans = Role.find_by_name(:executive_dean).users
    
    # syntax works and complaint gets escalated
    #test_user = User.find(3)
    
    # callback infinite loop if you use test_user_2 
    #test_user_2 = executive_deans.limit(1).pluck(:id)
    
    #test_user_3 = User.where(role: :executive_dean)
    
    
    #test_user_4 = User.joins(:roles).where(roles: {name: 'executive_dean'})
    
    
    executive_dean_to_escalate = User.joins(:roles).find_by(roles: {name: 'executive_dean'})
    
    if TimeDifference.between(start_time, end_time).in_seconds > 30 and self.completed == false
      
      #self.update_attribute(:escalated_to_user_id, executive_deans.ids)
      #self.update_attribute(:escalated_to_user_id, test_user.id)
      
      # update_attribute calls "save", so do not use after_save+_commit because you'll be stuck in callback loop
      # no don't use this
      #self.update_attribute(:escalated_to_user_id, test_user_2.id)
      
      self.update_attribute(:escalated_to_user_id, executive_dean_to_escalate.id)
      self.update_attribute(:escalated, true)
      self.update_attribute(:escalated_time, DateTime.now())
    
    end
  end
  

  private
  
    def self.to_csv
      attributes = %w{id title user_id assignee_id created_at last_reply_at completed escalated completed_time}
  
      CSV.generate(headers: true) do |csv|
        
        #do headers
        csv << attributes
  
        all.each do |complaint|  
          # original method to grab all attributes regardless of formatting
          #csv << attributes.map{ |attr| complaint.send(attr) }
          
          csv << [complaint.id, complaint.title, complaint.user.name, complaint.assignee.name, 
                  complaint.created_at, complaint.last_reply_at, complaint.completed, complaint.escalated, complaint.completed_time]
          
        end
      end
    end
    
    def export_complaint_stats
      
    end
    
    def calculate_stats_for_complaints
      
      total_complaints = Complaint.count
      total_closed_complaints = Complaint.where('completed = ?', true).count
      total_escalated_complaints = Complaint.where('escalated = ?', true).count
      
      
      start_time = self.created_at
      end_time = self.completed_time
      avg_time_to_complete_complaint = TimeDifference.between(start_time, end_time).in_hours
        
      
      all.each do |complaint|
       
      end
      
    end
    
  def update_last_reply_at_during_complaint_creation
    
    self.touch(:last_reply_at) 
          
  end

  
  
  #delegate :name, :to => :user, :prefix => true
  #delegate :assignee_id, :to => :user, :prefix => true
  
  
  
end
