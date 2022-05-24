require 'csv'

class User < ApplicationRecord
  rolify
  
  #rolify :before_add => :before_update_delete_roles

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #validates :roles, presence: true
  
  has_many :complaints, dependent: :destroy
  has_many :complaint_replies, dependent: :destroy
  has_many :assigned_complaints, class_name: 'Complaint', foreign_key: 'assignee_id', dependent: :nullify
  has_many :escalated_complaints, class_name: 'Complaint', foreign_key: 'escalated_to_user_id'
  has_many :messages
  
  has_one_attached :avatar
    
  #after_create :assign_default_role
  
  after_create_commit { broadcast_append_to "users" }
  

  validate :must_have_a_role, on: :update
  
  scope :all_except, -> (user) {
    
    where.not(id: user)  
    
  }
  
  scope :without_students, -> {
    
    where.not(id: User.with_role(:student).ids) 
    
  }
  
  scope :only_faculty, -> {
    
    where.not(id: User.with_role(:student).ids).where.not(id: User.with_role(:admin).ids)
    
  }
  

  private
  
    def must_have_a_role
      unless roles.any?
        errors.add(:roles, "Must have at least 1 role")
      end
    end
    
    def before_update_delete_roles(role)
      # do something before it gets added
      roles.delete(roles.where(:name => role))
    end
  
  
    def assign_default_role
      self.add_role(:student) if self.roles.blank?
    end
    
    
    def self.without_role(role)
      where.not(id: User.with_role(role).ids)
    end
    
    def self.to_csv
      attributes = %w{id name email}
  
      CSV.generate(headers: true) do |csv|
        csv << attributes
  
        all.each do |user|
          csv << attributes.map{ |attr| user.send(attr) }
        end
      end
    end
    
    def calculate_stats_for_users
    
    
    
    end
    
  
end
