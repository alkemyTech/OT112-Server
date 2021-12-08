class CreateContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :contacts do |t|
      t.string :name, null: false
      t.integer :phone, null: false
      t.string :email, null: false
      t.text :message, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
