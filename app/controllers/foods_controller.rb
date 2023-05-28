class FoodsController < ApplicationController
  before_action :find_user_restaurants, only: [:new, :edit, :create, :update]
  before_action :check_restaurant_owner, only: [:create, :edit, :update]

  def index
    @foods = Food.joins(:restaurant).where(restaurants: {user: @user})
  end

  def new
    @food = Food.new
  end

  def create
    @food = Food.new(food_params)

    if @food.save
      redirect_to foods_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @food = Food.find(params[:id])
  end

  def update
    @food = Food.find(params[:id])

    if @food.update(food_params)
      redirect_to foods_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy

    redirect_to foods_path, status: :see_other
  end

  private
    def food_params
      params.require(:food).permit(:name, :price, :description, :restaurant_id)
    end

    def find_user_restaurants
      @my_restaurants = Restaurant.where(user: @user)
    end

    def check_restaurant_owner
      if params[:food] && params[:food][:restaurant_id]
        restaurant = Restaurant.find(params[:food][:restaurant_id])
        if restaurant.user != @user
          flash[:notice] = 'Access denied'
          redirect_to foods_path
        end
      end

      if params[:id]
        food = Food.find(params[:id])
        if food.restaurant.user != @user
          flash[:notice] = 'Access denied'
          redirect_to foods_path
        end
      end
    end
end
