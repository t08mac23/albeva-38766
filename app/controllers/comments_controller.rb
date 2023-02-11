class CommentsController < ApplicationController

  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  # before_action :contributor_confirmation, only: [:edit, :update, :destroy]

  def create
    drink = Drink.find(params[:drink_id])
    comment = current_user.comments.new(comment_params)
    comment.drink_id = drink.id
    # @comment = Comment.create(comment_params)
    if comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      @drink = Drink.find(params[:drink_id])
      @comment = Comment.new
    #   # redirect_to "/drinks/#{@comment.drink.id}"
    #   render :drink_comments
    else
    #   @drink = @comment.drink
      # @comments = @drink.comments
      render "drinks/show"
    end
  end

  def edit
  end

  def update
    @comment.update
  end

  def destroy
    @drink = Drink.find(params[:drink_id])  
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

  # def contributor_confirmation
  #   redirect_to root_path unless current_user == @comment.user
  # end
end
