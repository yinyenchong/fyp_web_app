class AddLastReplyAtToComplaints < ActiveRecord::Migration[6.0]
  def change
    add_column :complaints, :last_reply_at, :datetime
  end
end
