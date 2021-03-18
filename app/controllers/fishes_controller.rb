class FishesController < ApplicationController
  def index
    @fishes = Fish.all
  end
end
