class FavoritesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  def create
    @drink = Drink.find(params[:drink_id])
    drink = Drink.find(params[:drink_id])
    favorite = Favorite.new(drink_id: drink.id)
    favorite.user_id = current_user.id
    favorite.save
  end

  def destroy
    @drink = Drink.find(params[:drink_id])
    drink = Drink.find(params[:drink_id])
    favorite = current_user.favorites.find_by(drink_id: drink.id)
    favorite.destroy
  end
end
