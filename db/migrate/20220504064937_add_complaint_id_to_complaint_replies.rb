class AddComplaintIdToComplaintReplies < ActiveRecord::Migration[6.0]
  def change
    add_reference :complaint_replies, :complaint, foreign_key: true
  end
end
