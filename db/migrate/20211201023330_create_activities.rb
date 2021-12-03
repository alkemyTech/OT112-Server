class CreateActivities < ActiveRecord::Migration[6.1]
  def change
    create_table :activities do |t|
      t.string :name
      t.text :content
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
