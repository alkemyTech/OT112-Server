class AddIndexToMembers < ActiveRecord::Migration[6.1]
  def change
      add_index :members, :deleted_at
  end
end
