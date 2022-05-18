class AddEscalatedToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :escalated, :boolean, default: false
  end
end
