class RemoveImageFromAnnouncements < ActiveRecord::Migration[6.1]
  def change
    remove_column :announcements, :image, :string
  end
end
