class RenameTypeToCommTypeInAnnouncements < ActiveRecord::Migration[6.1]
  def change
    rename_column :announcements, :type, :comm_type
  end
end
