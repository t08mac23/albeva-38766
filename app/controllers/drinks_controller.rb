class DrinksController < ApplicationController

  before_action :set_drink, only: [:show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @drinks = Drink.all.order("created_at DESC")
  end

  def new
    @drink = Drink.new
  end

  def create
    @drink = Drink.new(drink_params)
    if @drink.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @drink.update(drink_params)
      redirect_to drink_path
    else
      render :edit
    end
  end

  private

  def drink_params
    params.require(:drink).permit(:image, :name, :alc_percent, 
      :description, :combo, :genre_id, :sweet_dry_id, :recommendation_id, 
      :best_time_id).merge(user_id: current_user.id)
  end

  def set_drink
    @drink = Drink.find(params[:id])
  end
end
