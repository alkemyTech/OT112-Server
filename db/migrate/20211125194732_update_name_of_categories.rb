class UpdateNameOfCategories < ActiveRecord::Migration[6.1]
  def change
    change_column :categories, :name, :string
    change_column :categories, :name, :string, null: false 
    #Ex:- change_column("admin_users", "email", :string, :limit =>25) :name, null: false
  end
end
