class Menu < ActiveRecord::Base
	belongs_to :restaurant
	has_many :orders, :dependent => :destroy
	validates :name, presence: true
	validates :price, presence: true, numericality: true
end