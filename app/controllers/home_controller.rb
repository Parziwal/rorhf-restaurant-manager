class HomeController < ApplicationController
  def index
    @restaurants = [
      Restaurant.new(name: "Étterem 1", address: "Budapest, Kossuth utca 3.", description: "Leírás..."),
      Restaurant.new(name: "Étterem 2", address: "Budapest, Kossuth utca 4.", description: "Leírás..."),
      Restaurant.new(name: "Étterem 4", address: "Budapest, Kossuth utca 5.", description: "Leírás..."),
    ]
  end

  def show
    @restaurant = Restaurant.new(name: "Étterem 1", address: "Budapest, Kossuth utca 3.", description: "Leírás...")
    @foods = [
      Food.new(name: "Étel 1", price: 2400, description: "Leírás..."),
      Food.new(name: "Étel 2", price: 2500, description: "Leírás..."),
      Food.new(name: "Étel 3", price: 2610, description: "Leírás..."),
    ]
  end
end
