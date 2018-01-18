class OrdersController < ApplicationController
	protect_from_forgery
  def index
    @orders = Order.all
    respond_to do |format|
      format.json { render :json => { :orders => @orders }, status: :ok }
      format.html
    end
  end
  
  def new
    @order = Order.new
  end 

  def show
    begin
      @order = Order.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :order => @order }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end
 
  def edit
    begin
      @order = Order.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :order => @order }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
 
  def create
  	@order = Order.new(order_params)
    if @order.save
      respond_to do |format|
        format.json { render :json => { :order => @order }, status: :ok }
        format.html { redirect_to orders_path }
      end
    else
      respond_to do |format|
        format.json { render :json => { :order => @order.errors }, status: :unprocessable_entity }
        format.html { redirect_to new_order_path }
      end
    end
  end

  def update
    begin
      @order = Order.find(params[:id])
      if @order.update(order_params)
        redirect_to @order
      else
        respond_to do |format|
          format.json { render :json => { :order => @order.errors }, status: :unprocessable_entity }
          format.html { redirect_to edit_order_path }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
  
  def destroy
    begin
      @order = Order.find(params[:id])
      if @order.destroy
        respond_to do |format|
          format.json { render :json => { :message => 'Order was deleted successfully' }, status: :ok }
          format.html { redirect_to orders_path }
        end
      else
        respond_to do |format|
          format.json { render :json => { :order => @order.errors }, status: :unprocessable_entity }
          format.html
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  private
  def order_params
    params.require(:order).permit(:code, :food_details_with_quantity, :menu_id, :user_id)
  end
end