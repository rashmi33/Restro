class Order < ActiveRecord::Base
	belongs_to :menu
	belongs_to :user
	has_one :invoice, dependent: :destroy
	validates :code, presence: true, length: { is: 6 }
	validates :food_details_with_quantity, presence: true
end