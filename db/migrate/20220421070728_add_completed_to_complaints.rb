class AddCompletedToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :completed, :boolean, default: false
  end
end
