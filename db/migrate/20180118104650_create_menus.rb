class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
    	t.string :menu_type
    	t.string :name
    	t.decimal :price
    	t.references :restaurant, foreign_key: true
      t.timestamps null: false
    end
  end
end
