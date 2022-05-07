class CreateComplaintReplies < ActiveRecord::Migration[6.0]
  def change
    create_table :complaint_replies do |t|
      t.text :reply

      t.timestamps
    end
  end
end
