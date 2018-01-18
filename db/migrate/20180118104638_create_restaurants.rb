class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
    	t.string :name
    	t.string :address
    	t.string :city
    	t.string :phone_no
    	t.decimal :rating
    	t.boolean :is_veg, default: true
    	t.boolean :has_bar, default: false
      t.timestamps null: false
    end
  end
end
