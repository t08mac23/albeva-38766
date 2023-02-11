class FavoritesController < ApplicationController
  def create
    drink = Drink.find(params[:drink_id])
    favorite = Favorite.new(drink_id: drink.id)
    favorite.user_id = current_user.id
    favorite.save
    redirect_to request.referer
  end

  def destroy
    drink = Drink.find(params[:drink_id])
    favorite = current_user.favorites.find_by(drink_id: drink.id)
    favorite.destroy
    redirect_to request.referer
  end
end
