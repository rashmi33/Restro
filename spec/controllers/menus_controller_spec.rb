require 'rails_helper'

RSpec.describe MenusController, type: :controller do
  context 'GET #index' do
    it 'should display all the menus' do
      restaurant = FactoryGirl.create(:restaurant)
      FactoryGirl.create(:menu, restaurant_id: restaurant.id)
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
  end
  
  describe 'GET #new' do
    it 'should assign a new menu' do
      get :new
      expect(assigns(:menu)).to be_a_new(Menu)
    end
  end

  context 'GET #show' do
    context 'positive test' do
      it 'should show menu with given id' do
        restaurant = FactoryGirl.create(:restaurant)
        menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        get :show, id: menu.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not show invalid menu' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        get :show, id: 500, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not show invalid attribute' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        get :show, id: 'ABC', format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end
 
  context 'GET #edit' do
    context 'positive test' do
      it 'should edit menu with given id' do
        restaurant = FactoryGirl.create(:restaurant)
        menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        get :edit, id: menu.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not edit invalid menu' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        get :edit, id: 500, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end

  context 'POST #create' do
    context 'positive test' do
      it 'should create a valid menu with all attributes' do 
        restaurant = FactoryGirl.create(:restaurant)
        post :create, menu: { menu_type: 'Indian', name: Faker::Food.dish, price: Faker::Number.decimal(5,2), restaurant_id: restaurant.id}, format: :json
        response.should have_http_status(:ok)
      end
      it 'should create a valid menu with manadatory attributes only' do 
        restaurant = FactoryGirl.create(:restaurant)
        post :create, menu: { name: Faker::Food.dish, price: Faker::Number.decimal(5,2), restaurant_id: restaurant.id}, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not create a menu with invalid attributes' do
        FactoryGirl.create(:restaurant)
        post :create, menu: { name: Faker::Food.dish }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a menu with nil values' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        post :create, menu: { name: nil }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end 

  context 'PUT #update' do
    context 'positive test' do
      it 'should update the menu with valid attributes' do
        restaurant = FactoryGirl.create(:restaurant)
        menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        put :update, id: menu.id, menu: { menu_type: menu.menu_type, name: menu.name, price: menu.price}
        expect(response).to redirect_to menu_path(menu.id)
      end
    end
    context 'negative test' do
      it 'should not update menu with invalid id' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        put :update, { id:511 }, menu: { name: 'ABC' }, format: :json
        response.should have_http_status(:not_found)
      end
      it 'should not update menu with invalid attributes' do
        restaurant = FactoryGirl.create(:restaurant)
        menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        put :update, id: menu.id, menu: { menu_type: menu.menu_type, name: nil, price: menu.price }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE #destroy' do
    context 'positive test' do
      it 'should delete the menu' do
        restaurant = FactoryGirl.create(:restaurant)
        menu = FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        delete :destroy, id: menu.id, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not delete a menu with invalid id' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:menu, restaurant_id: restaurant.id)
        delete :destroy, id:555, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end
end