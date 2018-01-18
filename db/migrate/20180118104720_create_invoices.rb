class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
    	t.string :code
    	t.decimal :amount
    	t.references :order, foreign_key: true
      t.timestamps null: false
    end
  end
end
