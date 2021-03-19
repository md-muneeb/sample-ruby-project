class ItemsController < ApplicationController

  def index
    begin
      @items = Item.all
    rescue => e
      render json: {message: e}, status: 404
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
    begin
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e}, status: 404
    rescue => e
      render json: {message: e}, status: 404
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path
    else
      render :edit
    end
  end

  def destroy
    begin
      @item = Item.find(params[:id])
      @item.destroy
      redirect_to items_path
    rescue ActiveRecord::RecordNotFound => e
      render json: {message: e}, status: 404
    rescue => e
      render json: {message: e}, status: 404 
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :desc, :cost, :fish_id)
    end

end
