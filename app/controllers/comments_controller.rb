class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to "/drinks/#{@comment.drink.id}"
    else
      @drink = @comment.drink
      @comments = @drink.comments
      render "drinks/show"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, drink_id: params[:drink_id])
  end
end
