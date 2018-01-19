require 'rails_helper'

RSpec.describe RestaurantsController, type: :controller do
  context 'GET #index' do
    it 'should display all the restaurants' do
      FactoryGirl.create(:restaurant)
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
  end
  
  describe 'GET #new' do
    it 'should assign a new restaurant' do
      get :new
      expect(assigns(:restaurant)).to be_a_new(Restaurant)
    end
  end

  context 'GET #show' do
    context 'positive test' do
      it 'should show restaurant with given id' do
        restaurant = FactoryGirl.create(:restaurant)
        get :show, id: restaurant.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not show invalid restaurant' do
        FactoryGirl.create(:restaurant)
        get :show, id: 500, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not show invalid attribute' do
        FactoryGirl.create(:restaurant)
        get :show, id: 'ABC', format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'GET #edit' do
    context 'positive test' do
      it 'should edit restaurant with given id' do
        restaurant = FactoryGirl.create(:restaurant)
        get :edit, id: restaurant.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not edit invalid restaurant' do
        FactoryGirl.create(:restaurant)
        get :edit, id: 500, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end

  context 'POST #create' do
    context 'positive test' do
      it 'should create a valid restaurant with all attributes' do 
        post :create, restaurant: { name: Faker::Name.first_name, address: Faker::Address.street_address, city: Faker::Address.city, phone_no: Faker::Number.number(17), rating: Faker::Number.number(1), is_veg: 'true', has_bar: 'false' }, format: :json
        response.should have_http_status(:ok)
      end
      it 'should create a valid restaurant with manadatory attributes only' do 
        post :create, restaurant: { name: Faker::Name.first_name, address: Faker::Address.street_address, city: Faker::Address.city, phone_no: Faker::Number.number(17) }, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not create a restaurant with invalid attributes' do
        FactoryGirl.create(:restaurant)
        post :create, restaurant: { name: Faker::Name.first_name }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a restaurant with nil values' do
        FactoryGirl.create(:restaurant)
        post :create, restaurant: { name: nil }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end 

  context 'PUT #update' do
    context 'positive test' do
      it 'should update the restaurant with valid attributes' do
        restaurant = FactoryGirl.create(:restaurant)
        put :update, id: restaurant.id, restaurant: { name: restaurant.name, address: restaurant.address, city: restaurant.city, phone_no: restaurant.phone_no, rating: restaurant.rating, is_veg: restaurant.is_veg, has_bar: restaurant.has_bar }
        expect(response).to redirect_to restaurant_path(restaurant.id)
      end
    end
    context 'negative test' do
      it 'should not update restaurant with invalid id' do
        FactoryGirl.create(:restaurant)
        put :update, { id: 511 }, restaurant: { name: 'ABC' }, format: :json
        response.should have_http_status(:not_found)
      end
      it 'should not update restaurant with invalid attributes' do
        restaurant = FactoryGirl.create(:restaurant)
        put :update, id: restaurant.id, restaurant: { name: nil, address: restaurant.address, city: restaurant.city, phone_no: restaurant.phone_no, rating: restaurant.rating, is_veg: restaurant.is_veg, has_bar: restaurant.has_bar }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE #destroy' do
    context 'positive test' do
      it 'should delete the restaurant' do
        restaurant = FactoryGirl.create(:restaurant)
        delete :destroy, id: restaurant.id, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not delete a restaurant with invalid id' do
        FactoryGirl.create(:restaurant)
        delete :destroy, id: 555, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end
end