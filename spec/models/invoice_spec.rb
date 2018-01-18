require 'rails_helper'

RSpec.describe Invoice, type: :model do
	context 'creation' do
    it 'creates a invoice_type with all valid attributes' do
      FactoryGirl.build(:invoice).should be_valid
    end
  end

  context 'validations' do
    it 'is valid with a code' do
      FactoryGirl.build(:invoice, code:'AB111C').should be_valid
    end

    it 'is invalid with a code' do
      FactoryGirl.build(:invoice, code: 'ABC51').should_not be_valid
    end

    it 'is invalid with a code' do
      FactoryGirl.build(:invoice, code: 'ABC5661').should_not be_valid
    end

    it 'is invalid without a code' do
      FactoryGirl.build(:invoice, code: nil).should_not be_valid
    end

    it 'is valid with an amount' do
      FactoryGirl.build(:invoice, amount: '200').should be_valid
    end

    it 'is invalid without an amount' do
      FactoryGirl.build(:invoice, amount: nil).should_not be_valid
    end
  end

  context 'associations' do
  	it 'should belong to order'do
      order = FactoryGirl.create(:order)
      invoice = FactoryGirl.create(:invoice, order_id: order.id)
      invoice.order.id.should eq order.id
    end
  end
end