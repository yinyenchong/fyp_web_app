class AddUserIdToComplaints < ActiveRecord::Migration[6.0]
  def change
   
    add_reference :complaints, :user, foreign_key: true


  end
end
