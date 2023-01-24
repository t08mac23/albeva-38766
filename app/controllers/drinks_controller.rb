class DrinksController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create]

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

  private

  def drink_params
    params.require(:drink).permit(:image, :name, :alc_percent, 
      :description, :combo, :genre_id, :sweet_dry_id, :recommendation_id, 
      :best_time_id).merge(user_id: current_user.id)
  end

end
