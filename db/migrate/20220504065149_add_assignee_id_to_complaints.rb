class AddAssigneeIdToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :assignee_id, :integer, array: true, default: []
    
    add_index :complaints, :assignee_id
  end
end
