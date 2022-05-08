class Complaint < ApplicationRecord
  
 
<<<<<<< HEAD

=======
>>>>>>> complaint-replies
  
  belongs_to :user, optional: false
  belongs_to :assignee, class_name: 'User', optional: false
  
  
  validates_presence_of :user_id
  validates_presence_of :assignee_id
  validates_presence_of :title, presence: true
  validates_presence_of :body, presnece: true
  
  has_one_attached :complaintfile
  
  has_many :complaint_replies, dependent: :destroy
  
  
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
      .where('reviews.created_at > ?', 1.week.ago)
  }
  
  
  scope :in_progress, -> { 
    where(completed: false) 
    
  }
  
  scope :filter_by_staff, -> {
    
    where('!current_user.has_role? :student')
    
  }

  
  

  
  
  #delegate :name, :to => :user, :prefix => true
  #delegate :assignee_id, :to => :user, :prefix => true
  
  
  
end
