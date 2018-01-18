require 'rails_helper'

RSpec.describe Menu, type: :model do
	context 'creation' do
    it 'creates a menu_type with all valid attributes' do
      FactoryGirl.build(:menu).should be_valid
    end
  end

  context 'validations' do
    it 'is valid with a name' do
      FactoryGirl.build(:menu, name:'ABC').should be_valid
    end

    it 'is valid with a price' do
      FactoryGirl.build(:menu, price: '200').should be_valid
    end

    it 'is valid without a menu_type' do
      FactoryGirl.build(:menu, menu_type: nil).should be_valid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:menu, name: nil).should_not be_valid
    end

    it 'is invalid without a price' do
      FactoryGirl.build(:menu, price: nil).should_not be_valid
    end
  end

  context 'associations' do
  	it 'should have many orders'do
      menu = FactoryGirl.create(:menu)
      user = FactoryGirl.create(:user)
      order = FactoryGirl.create(:order, menu_id: menu.id, user_id: user.id)
      menu.orders.includes(order)
    end

    it 'should belong to restaurant'do
      restaurant = FactoryGirl.create(:restaurant)
      menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
      menu.restaurant.id.should eq restaurant.id
    end
  end
end