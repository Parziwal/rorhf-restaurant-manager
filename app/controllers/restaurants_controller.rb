class RestaurantsController < ApplicationController
  before_action :check_restaurant_owner, only: [:edit, :update]

  def index
    @restaurants = Restaurant.where(user: @user)
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    
    if @restaurant.save
      redirect_to restaurants_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])

    if @restaurant.update(restaurant_params)
      redirect_to restaurants_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @restaurant = Restaurant.find(params[:id])
    @restaurant.destroy

    redirect_to restaurants_path, status: :see_other
  end

  private
    def restaurant_params
      params.require(:restaurant).permit(:name, :address, :description, :user_id)
    end

    def check_restaurant_owner
      restaurant = Restaurant.find_by(id: params[:id], user: @user)
      unless restaurant
        flash[:notice] = 'Access denied'
        redirect_to restaurants_path
      end
    end
end
