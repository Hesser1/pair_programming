class CommentsController < ApplicationController
  def index
    @movie = Movie.find(params[:movie_id])
    if current_user
      @user_has_comment = @movie.comments.size > 0 && @movie.comments.find_by_user_id(current_user.id)
      @comment = @movie.comments.all unless @user_has_comment
    end
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.new(comment_params) do |c|
      c.user = current_user
    end

    if @comment.save()
      redirect_back(fallback_location: root_path, notice: "Comment was successfully created")
    else
      redirect_back(fallback_location: root_path, alert: @comment.errors)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_back(fallback_location: root_path, notice: "Comment was successfully deleted")
    else
      redirect_back(fallback_location: root_path, alert: @comment.errors)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:comment)
  end
end