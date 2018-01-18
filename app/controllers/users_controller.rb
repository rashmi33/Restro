class UsersController < ApplicationController
	protect_from_forgery
  def index
    @users = User.all
    respond_to do |format|
      format.json { render :json => { :users => @users }, status: :ok }
      format.html
    end
  end
  
  def new
    @user = User.new
  end 

  def show
    begin
      @user = User.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :user => @user }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  def edit
    begin
      @user = User.find(params[:id])
      respond_to do |format|
        format.json { render :json => { :user => @user }, status: :ok }
        format.html
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
 
  def create
  	@user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.json { render :json => { :user => @user }, status: :ok }
        format.html { redirect_to users_path }
      end
    else
      respond_to do |format|
        format.json { render :json => { :user => @user.errors }, status: :unprocessable_entity }
        format.html { redirect_to new_user_path }
      end
    end
  end

  def update
    begin
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to @user
      else
        respond_to do |format|
          format.json { render :json => { :user => @user.errors }, status: :unprocessable_entity }
          format.html { redirect_to edit_user_path }
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end
  
  def destroy
    begin
      @user = User.find(params[:id])
      if @user.destroy
        respond_to do |format|
          format.json { render :json => { :message => 'User was deleted successfully' }, status: :ok }
          format.html { redirect_to users_path }
        end
      else
        respond_to do |format|
          format.json { render :json => { :user => @user.errors }, status: :unprocessable_entity }
          format.html
        end
      end
    rescue ActiveRecord::RecordNotFound => e
      render json: { error: e.message }, status: :not_found
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :address, :phone_no, :restaurant_id)
  end
end