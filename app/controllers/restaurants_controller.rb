class RestaurantsController < ApplicationController
	protect_from_forgery
  def index
    @restaurants = Restaurant.all
    respond_to do |format|
      format.json { render json: { restaurants: @restaurants }, status: :ok }
      format.html
    end
  end
  
  def new
    @restaurant = Restaurant.new
  end 

  def show
    begin
      @restaurant = Restaurant.find(params[:id])
      respond_to do |format|
        format.json { render json: { restaurant: @restaurant }, status: :ok } 
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def edit
    begin
      @restaurant = Restaurant.find(params[:id])
      respond_to do |format|
        format.json { render json: { restaurant: @restaurant }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
 
  def create
  	@restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      respond_to do |format|
        format.json { render json: { restaurant: @restaurant }, status: :ok }
        format.html { redirect_to restaurants_path }
      end
    else
      respond_to do |format|
        format.json { render json: { restaurant: @restaurant.errors }, status: :unprocessable_entity }
        format.html { redirect_to new_restaurant_path }
      end
    end
  end

  def update
    begin
      @restaurant = Restaurant.find(params[:id])
      if @restaurant.update(restaurant_params)
        redirect_to @restaurant
      else
        respond_to do |format|
          format.json { render json: { restaurant: @restaurant.errors }, status: :unprocessable_entity }
          format.html { redirect_to edit_restaurant_path }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
  
  def destroy
    begin
      @restaurant = Restaurant.find(params[:id])
      if @restaurant.destroy
        respond_to do |format|
          format.json { render json: { message: 'Restaurant was deleted successfully' }, status: :ok }
          format.html { redirect_to restaurants_path }
        end
      else
        respond_to do |format|
          format.json { render json: { restaurant: @restaurant.errors }, status: :unprocessable_entity }
          format.html
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :city, :phone_no, :rating, :is_veg, :has_bar)
  end
end