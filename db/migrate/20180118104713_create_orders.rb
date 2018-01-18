class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
    	t.string :code
    	t.text :food_details_with_quantity
    	t.references :menu, foreign_key: true
    	t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
