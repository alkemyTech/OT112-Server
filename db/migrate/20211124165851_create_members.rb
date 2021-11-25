class CreateMembers < ActiveRecord::Migration[6.1]
  def change
    create_table :members do |t|

      t.string :name, null: false, limit: 255
      t.string :facebookUrl, limit: 255
      t.string :instagramUrl, limit: 255
      t.string :linkedinUrl, limit: 255
      t.text :description, limit: 255
      t.datetime  :deleted_at
      t.timestamps
    
    end
  end
end
