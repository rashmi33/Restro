class Restaurant < ActiveRecord::Base
	has_many :users, dependent: :destroy
	has_many :menus, dependent: :destroy
	validates :name, presence: true
	validates :address, presence: true
	validates :city, presence: true
	validates :phone_no, presence: true, length: { maximum: 17, minimum: 5 }, numericality: { only_integer: true }
end