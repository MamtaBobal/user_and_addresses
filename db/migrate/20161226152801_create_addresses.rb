class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :desc
      t.references :user
      t.boolean :active
      t.timestamps null: false
    end
  end
end
