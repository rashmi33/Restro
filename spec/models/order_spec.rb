require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'creation' do
    it 'creates a order with all valid attributes' do
      FactoryGirl.build(:order).should be_valid
    end
  end

  context 'validations' do
    it 'is valid with a code' do
      FactoryGirl.build(:order, code:'AB1234').should be_valid
    end

    it 'is valid with a food_details_with_quantity' do
      FactoryGirl.build(:order, food_details_with_quantity: 'ABC-12').should be_valid
    end

    it 'is invalid with a code' do
      FactoryGirl.build(:order, code: 'ABC51').should_not be_valid
    end

    it 'is invalid with a code' do
      FactoryGirl.build(:order, code: 'ABC5661').should_not be_valid
    end

    it 'is invalid without a code' do
      FactoryGirl.build(:order, code: nil).should_not be_valid
    end

    it 'is invalid without a food_details_with_quantity' do
      FactoryGirl.build(:order, food_details_with_quantity: nil).should_not be_valid
    end
  end
  
  before :each do
    restaurant = FactoryGirl.create(:restaurant)
    @menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
    @user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
    @order = FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
  end

  context 'associations' do
    it 'should have one invoice' do
      invoice = FactoryGirl.create(:invoice, order_id: @order.id)
      @order.invoice.id.should eq invoice.id
    end

    it 'should belong to menu' do
      @order.menu.id.should eq @menu.id
    end

    it 'should belong to user' do
      @order.user.id.should eq @user.id
    end
  end
end