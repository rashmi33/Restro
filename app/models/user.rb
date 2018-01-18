class User < ActiveRecord::Base
	belongs_to :restaurant
	has_many :orders, :dependent => :destroy
	validates :name, presence: true
	validates :address, presence: true
	validates :phone_no, presence: true, length: { maximum: 17, minimum: 5 }, numericality: { only_integer: true }
end