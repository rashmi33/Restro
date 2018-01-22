require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  before :each do
    restaurant = FactoryGirl.create(:restaurant)
    @menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
    @user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
  end

  context 'GET #index' do
    it 'should display all the orders' do
      FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
  end
  
  describe 'GET #new' do
    it 'should assign a new order' do
      get :new
      expect(assigns(:order)).to be_a_new(Order)
    end
  end

  context 'GET #show' do
    context 'positive test' do
      it 'should show order with given id' do
        order = FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        get :show, id: order.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not show invalid order' do
        FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        get :show, id: 500, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not show invalid attribute' do
        FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        get :show, id: 'ABC', format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'GET #edit' do
    context 'positive test' do
      it 'should edit order with given id' do
        order = FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        get :edit, id: order.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not edit invalid order' do
        FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        get :edit, id: 500, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end

  context 'POST #create' do
    context 'positive test' do
      it 'should create a valid order with all attributes' do
        post :create, order: { code: 'A7878A', food_details_with_quantity: Faker::Food.description, menu_id: @menu.id, user_id: @user.id }, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not create a order with invalid attributes' do
        post :create, order: { code: 'AAS233', menu_id: @menu.id, user_id: @user.id }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a order with nil values' do
        FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        post :create, order: { code: nil }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end 

  context 'PUT #update' do
    context 'positive test' do
      it 'should update the order with valid attributes' do
        order = FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        put :update, id: order.id, order: { code: order.code, food_details_with_quantity: order.food_details_with_quantity }
        expect(response).to redirect_to order_path(order.id)
      end   
    end
    context 'negative test' do
      it 'should not update user with invalid id' do
        FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        put :update, { id: 511 }, order: { code: 'ABC122' }, format: :json
        response.should have_http_status(:not_found)
      end
      it 'should not update user with invalid attributes' do
        order = FactoryGirl.create(:order, menu_id:@menu.id, user_id: @user.id)
        put :update, id: order.id, order: { code: nil, food_details_with_quantity: order.food_details_with_quantity }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE #destroy' do
    context 'positive test' do
      it 'should delete the order' do
        order = FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        delete :destroy, id: order.id, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not delete a user with invalid id' do
        FactoryGirl.create(:order, menu_id: @menu.id, user_id: @user.id)
        delete :destroy, id: 555, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end
end
