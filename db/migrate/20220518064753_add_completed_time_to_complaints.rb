class AddCompletedTimeToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :completed_time, :datetime
  end
end
