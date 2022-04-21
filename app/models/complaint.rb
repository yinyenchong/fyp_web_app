class Complaint < ApplicationRecord
  
  belongs_to :user
  
  has_one_attached :complaintfile
  
end
