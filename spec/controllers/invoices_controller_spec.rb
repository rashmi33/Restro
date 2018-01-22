require 'rails_helper'

RSpec.describe InvoicesController, type: :controller do
  before :each do
    restaurant = FactoryGirl.create(:restaurant)
    menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
    user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
    @order = FactoryGirl.create(:order, menu_id: menu.id, user_id: user.id)
  end

  context 'GET #index' do
    it 'should display all the invoices' do
      FactoryGirl.create(:invoice, order_id: @order.id)
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
  end

  describe 'GET #new' do
    it 'should assign a new invoice' do
      get :new
      expect(assigns(:invoice)).to be_a_new(Invoice)
    end
  end
  
  context 'GET #show' do 
    context 'positive test' do
      it 'should show invoice with given id' do
        invoice = FactoryGirl.create(:invoice, order_id: @order.id)
        get :show, id: invoice.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not show invalid invoice' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        get :show, id: 500, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not show invalid attribute' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        get :show, id: 'ABC', format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'GET #edit' do
    context 'positive test' do
      it 'should edit invoice with given id' do
        invoice = FactoryGirl.create(:invoice, order_id: @order.id)
        get :edit, id: invoice.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not edit invalid invoice' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        get :edit, id: 500, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end

  context 'POST #create' do
    context 'positive test' do
      it 'should create a valid invoice with all attributes' do
        post :create, invoice: { code: 'A7878A', amount: Faker::Number.decimal(5, 2), order_id: @order.id }, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not create a invoice with invalid attributes' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        post :create, invoice: { code: 'AA5561' }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a invoice with nil values' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        post :create, invoice: { code: nil }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'PUT #update' do
    context 'positive test' do
      it 'should update the invoice with valid attributes' do
        invoice = FactoryGirl.create(:invoice, order_id: @order.id)
        put :update, id: invoice.id, invoice: { code: invoice.code, amount: invoice.amount }
        expect(response).to redirect_to invoice_path(invoice.id)
      end
    end
    context 'negative test' do
      it 'should not update invoice with invalid id' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        put :update, { id: 511 }, invoice: { name: 'ABC' }, format: :json
        response.should have_http_status(:not_found)
      end
      it 'should not update invoice with invalid attributes' do
        invoice = FactoryGirl.create(:invoice, order_id: @order.id)
        put :update, id: invoice.id, invoice: { code: nil, amount: invoice.amount }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE #destroy' do
    context 'positive test' do
      it 'should delete the invoice' do
        invoice = FactoryGirl.create(:invoice, order_id: @order.id)
        delete :destroy, id: invoice.id, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not delete a invoice with invalid id' do
        FactoryGirl.create(:invoice, order_id: @order.id)
        delete :destroy, id: 555, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end
end