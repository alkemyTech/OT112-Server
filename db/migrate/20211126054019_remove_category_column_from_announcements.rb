class RemoveCategoryColumnFromAnnouncements < ActiveRecord::Migration[6.1]
  def change
    remove_column :announcements, :category
  end
end
