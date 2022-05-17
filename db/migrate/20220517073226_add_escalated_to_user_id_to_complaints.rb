class AddEscalatedToUserIdToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :escalated_to_user_id, :integer
    
    add_index :complaints, :escalated_to_user_id
  end
end
