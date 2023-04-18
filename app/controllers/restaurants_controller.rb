class RestaurantsController < ApplicationController
  def index
    @restaurants = [
      Restaurant.new(id: 1, name: "Étterem 1", address: "Budapest, Kossuth utca 3.", description: "Leírás..."),
      Restaurant.new(id: 2, name: "Étterem 2", address: "Budapest, Kossuth utca 4.", description: "Leírás..."),
      Restaurant.new(id: 3, name: "Étterem 4", address: "Budapest, Kossuth utca 5.", description: "Leírás..."),
    ]
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
