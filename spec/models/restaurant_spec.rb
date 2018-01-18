require 'rails_helper'

RSpec.describe Restaurant, type: :model do
	context 'creation' do
    it 'creates a restaurant with all valid attributes' do
      FactoryGirl.build(:restaurant).should be_valid
    end
  end

  context 'validations' do
    it 'is valid with a name' do
      FactoryGirl.build(:restaurant, name:'ABC').should be_valid
    end

    it 'is valid with a address' do
      FactoryGirl.build(:restaurant, address: 'ABC').should be_valid
    end

    it 'is valid with a city' do
      FactoryGirl.build(:restaurant, city: 'ABC').should be_valid
    end

    it 'is valid with a phone_no' do
      FactoryGirl.build(:restaurant, phone_no: '878888').should be_valid
    end

    it 'is invalid with a phone_no' do
      FactoryGirl.build(:restaurant, phone_no: 'ABC566577').should_not be_valid
    end

    it 'is valid without a rating' do
      FactoryGirl.build(:restaurant, rating: nil).should be_valid
    end

    it 'is valid without a is_veg' do
      FactoryGirl.build(:restaurant, is_veg: nil).should be_valid
    end

    it 'is valid without a has_bar' do
      FactoryGirl.build(:restaurant, has_bar: nil).should be_valid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:restaurant, name: nil).should_not be_valid
    end

    it 'is invalid without a address' do
      FactoryGirl.build(:restaurant, address: nil).should_not be_valid
    end

    it 'is invalid without a city' do
      FactoryGirl.build(:restaurant, city: nil).should_not be_valid
    end

    it 'is invalid without a phone_no' do
      FactoryGirl.build(:restaurant, phone_no: nil).should_not be_valid
    end
  end

  context 'associations' do
    it 'should have many users'do
      restaurant = FactoryGirl.create(:restaurant)
      user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
      restaurant.users.includes(user)
    end

    it 'should have many menus'do
      restaurant = FactoryGirl.create(:restaurant)
      menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
      restaurant.menus.includes(menu)
    end
  end
end