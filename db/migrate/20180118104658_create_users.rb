class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :name
    	t.string :address
    	t.string :phone_no
    	t.references :restaurant, foreign_key: true
      t.timestamps null: false
    end
  end
end
