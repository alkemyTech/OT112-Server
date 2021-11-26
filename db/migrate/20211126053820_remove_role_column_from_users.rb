class RemoveRoleColumnFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :role_id
  end
end
