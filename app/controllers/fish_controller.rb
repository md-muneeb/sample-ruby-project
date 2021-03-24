class FishController < ApplicationController

  def index
    begin
      @fish = Fish.all
    rescue => e
      render json: {message: e}, status: 404
    end
  end

  def new
    @fish = Fish.new
  end

  def create
    @fish = Fish.new(fish_params)
    if @fish.save
      redirect_to fish_index_path
    else
      render :new
    end
  end

  def edit
    begin
      @fish = Fish.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e}, status: 404
    rescue => e
      render json: {message: e}, status: 404
    end
  end

  def update
    @fish = Fish.find(params[:id])
    if @fish.update(fish_params)
      redirect_to fish_index_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @fish = Fish.find(params[:id])
      @fish.destroy
      redirect_to fish_index_path
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e}, status: 404
    rescue => e
      render json: {message: e}, status: 404 
    end
  end

  private
    def fish_params
      params.require(:fish).permit(:name, :age)
    end

end
