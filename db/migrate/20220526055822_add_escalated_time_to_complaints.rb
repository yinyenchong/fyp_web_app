class AddEscalatedTimeToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :escalated_time, :datetime
  end
end
