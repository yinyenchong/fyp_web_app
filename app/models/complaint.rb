class Complaint < ApplicationRecord
  
  validates_presence_of :user_id

  
  belongs_to :user, optional: false
  belongs_to :assignee, class_name: 'User', optional: false
  
  has_one_attached :complaintfile
  
  has_many :complaint_replies, dependent: :destroy
  
  
  
  #delegate :name, :to => :user, :prefix => true
  #delegate :assignee_id, :to => :user, :prefix => true
  
  
  
end
