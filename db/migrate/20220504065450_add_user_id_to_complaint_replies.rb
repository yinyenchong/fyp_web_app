class AddUserIdToComplaintReplies < ActiveRecord::Migration[6.0]
  def change
    add_reference :complaint_replies, :user, foreign_key: true
  end
end
