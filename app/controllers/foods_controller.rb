class FoodsController < ApplicationController
  def index
    @foods = [
      Food.new(id: 1, name: "Étel 1", price: 2400, description: "Leírás..."),
      Food.new(id: 2, name: "Étel 2", price: 2500, description: "Leírás..."),
      Food.new(id: 3, name: "Étel 3", price: 2610, description: "Leírás..."),
    ]
  end

  def new
    @food = Food.new
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
