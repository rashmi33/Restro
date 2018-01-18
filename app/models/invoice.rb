class Invoice < ActiveRecord::Base
	belongs_to :order
	validates :code, presence: true, length: { is: 6 }
	validates :amount, presence: true, numericality: true 
end