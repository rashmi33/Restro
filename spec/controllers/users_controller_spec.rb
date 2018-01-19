require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  context 'GET #index' do
    it 'should display all the users' do
      restaurant = FactoryGirl.create(:restaurant)
      FactoryGirl.create(:user, restaurant_id: restaurant.id)
      get :index, format: 'json'
      response.should have_http_status(:ok)
    end
  end
  
  describe 'GET #new' do
    it 'should assign a new user' do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  context 'GET #show' do
    context 'positive test' do
      it 'should show user with given id' do
        restaurant = FactoryGirl.create(:restaurant)
        user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
        get :show, id: user.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not show invalid user' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:user, restaurant_id: restaurant.id)
        get :show, id: 500, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not show invalid attribute' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:user, restaurant_id: restaurant.id)
        get :show, id: 'ABC', format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'GET #edit' do
    context 'positive test' do
      it 'should edit user with given id' do
        restaurant = FactoryGirl.create(:restaurant)
        user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
        get :edit, id: user.id, format: 'json'
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not edit invalid user' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:user, restaurant_id: restaurant.id)
        get :edit, id: 500, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end

  context 'POST #create' do
    context 'positive test' do
      it 'should create a valid user with all attributes' do 
        restaurant = FactoryGirl.create(:restaurant)
        post :create, user: { name: Faker::Name.first_name, address: Faker::Address.street_address, phone_no: Faker::Number.number(17), restaurant_id: restaurant.id }, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not create a user with invalid attributes' do
        FactoryGirl.create(:restaurant)
        post :create, user: { name: Faker::Name.first_name }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
      it 'should not create a user with nil values' do
        FactoryGirl.create(:restaurant)
        post :create, user: { name: nil }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end 

  context 'PUT #update' do
    context 'positive test' do
      it 'should update the user with valid attributes' do
        restaurant = FactoryGirl.create(:restaurant)
        user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
        put :update, id: user.id, user: { name: user.name, address: user.address, phone_no: user.phone_no }
        expect(response).to redirect_to user_path(user.id)
      end
    end
    context 'negative test' do
      it 'should not update user with invalid id' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:user,restaurant_id: restaurant.id)
        put :update, { id: 511 }, user: { name: 'ABC' }, format: :json
        response.should have_http_status(:not_found)
      end
      it 'should not update user with invalid attributes' do
        restaurant = FactoryGirl.create(:restaurant)
        user = FactoryGirl.create(:user,restaurant_id: restaurant.id)
        put :update, id: user.id, user: { name: nil, address: user.address, phone_no: user.phone_no }, format: :json
        response.should have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'DELETE #destroy' do
    context 'positive test' do
      it 'should delete the user' do
        restaurant = FactoryGirl.create(:restaurant)
        user = FactoryGirl.create(:user, restaurant_id: restaurant.id)
        delete :destroy, id: user.id, format: :json
        response.should have_http_status(:ok)
      end
    end
    context 'negative test' do
      it 'should not delete a user with invalid id' do
        restaurant = FactoryGirl.create(:restaurant)
        FactoryGirl.create(:user, restaurant_id: restaurant.id)
        delete :destroy, id: 555, format: :json
        response.should have_http_status(:not_found)
      end
    end
  end
end