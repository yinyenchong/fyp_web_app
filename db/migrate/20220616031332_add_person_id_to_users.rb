class AddPersonIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :person_id, :string
  end
end
