class CommentsController < ApplicationController

  before_action :set_comment, only: [:destroy]
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    # drink = Drink.find(params[:drink_id])
    # comment = current_user.comments.new(comment_params)
    # comment.drink_id = drink.id
    @comment = Comment.create(comment_params)
    respond_to do |format|
      format.html { redirect_to drink_path(params[:drink_id]) }
      format.json
    end
    # if comment.save

    # @drinks = Drink.find(params[:drink_id])
    # @comment = Comment.new

    #   # redirect_to "/drinks/#{@comment.drink.id}"
    #   render :drink_comments
    # else
    #   @drink = @comment.drink
      # @comments = @drink.comments
      # render "drinks/show"
    # end
  end

  def destroy
    @drinks = Drink.find(params[:drink_id])  
    @comment.destroy
    flash.now[:alert] = '投稿を削除しました'
    #renderしたときに@drinkのデータがないので@drinkを定義
    # @drink = Drink.find(params[:drink_id])  
    # render :drink_comments  #render先にjsファイルを指定
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, drink_id: params[:drink_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
