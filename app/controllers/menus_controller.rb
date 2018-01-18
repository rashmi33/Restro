class MenusController < ApplicationController
	protect_from_forgery
  def index
    @menus = Menu.all
    respond_to do |format|
      format.json { render :json => { :menus => @menus }, status: :ok }
      format.html
    end
  end
  
  def new
    @menu = Menu.new
  end

  def show
    begin
      @menu = Menu.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :menu => @menu }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def edit
    begin
      @menu = Menu.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :menu => @menu }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
 
  def create
  	@menu = Menu.new(menu_params)
    if @menu.save
      respond_to do |format|
        format.json { render :json => { :menu => @menu }, status: :ok }
        format.html { redirect_to menus_path }
      end
    else
      respond_to do |format|
        format.json { render :json => { :menu => @menu.errors }, status: :unprocessable_entity }
        format.html { redirect_to new_menu_path }
      end
    end
  end

  def update
    begin
      @menu = Menu.find(params[:id])
      if @menu.update(menu_params)
        redirect_to @menu
      else
        respond_to do |format|
          format.json { render :json => { :menu => @menu.errors }, status: :unprocessable_entity }
          format.html { redirect_to edit_menu_path }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message}, status: :not_found
    end
  end
  
  def destroy
    begin
      @menu = Menu.find(params[:id])
      if @menu.destroy
        respond_to do |format|
          format.json { render :json => { :message => 'Menu was deleted successfully' }, status: :ok }
          format.html { redirect_to menus_path }
        end
      else
        respond_to do |format|
          format.json { render :json => { :menu => @menu.errors }, status: :unprocessable_entity }
          format.html
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  private
  def menu_params
    params.require(:menu).permit(:menu_type, :name, :price, :restaurant_id)
  end
end