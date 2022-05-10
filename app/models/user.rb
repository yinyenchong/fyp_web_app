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
  
  
  
  has_one_attached :avatar
  
    
  #after_create :assign_default_role
  

  validate :must_have_a_role, on: :update

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
  
  
  
  scope :staff_members, -> { 
    
    where.not(id: User.with_role(:student).ids) and where.not(id: User.with_role(:admin).ids)
    
  }
  
  def self.without_role(role)
    where.not(id: User.with_role(role).ids)
  end
  

  
  
end
