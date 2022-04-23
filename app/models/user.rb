class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #validates :roles, presence: true
  
  has_many :complaints
  has_one_attached :avatar
  
    
  #after_create :assign_default_role

  validate :must_have_a_role, on: :update

  private

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "must have at least 1 role")
    end
  end


  def assign_default_role
    self.add_role(:student) if self.roles.blank?
  end

  
  
end
