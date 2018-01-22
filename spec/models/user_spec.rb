require 'rails_helper'

RSpec.describe User, type: :model do
	context 'creation' do
    it 'creates a user with all valid attributes' do
      FactoryGirl.build(:user).should be_valid
    end
  end

  context 'validations' do
    it 'is valid with a name' do
      FactoryGirl.build(:user, name:'ABC').should be_valid
    end

    it 'is valid with a address' do
      FactoryGirl.build(:user, address: 'ABC-12').should be_valid
    end

    it 'is valid with a phone_no' do
      FactoryGirl.build(:user, phone_no: '877677').should be_valid
    end

    it 'is invalid with a phone_no' do
      FactoryGirl.build(:user, phone_no: 'ABC566577').should_not be_valid
    end

    it 'is invalid without a name' do
      FactoryGirl.build(:user, name: nil).should_not be_valid
    end

    it 'is invalid without a address' do
      FactoryGirl.build(:user, address: nil).should_not be_valid
    end

    it 'is invalid without a city' do
      FactoryGirl.build(:user, phone_no: nil).should_not be_valid
    end
  end

  context 'associations' do
    it 'should have many orders'do
      restaurant = FactoryGirl.create(:restaurant)
      user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
      order = FactoryGirl.create(:order, user_id: user.id)
      user.orders.includes(order)
    end

    it 'should belong to restaurant'do
      restaurant = FactoryGirl.create(:restaurant)
      user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
      user.restaurant.id.should eq restaurant.id
    end
  end
end