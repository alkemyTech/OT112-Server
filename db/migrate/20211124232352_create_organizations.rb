class CreateOrganizations < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :address
      t.integer :phone
      t.string :email
      t.text :welcomeText
      t.text :aboutUsText
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
