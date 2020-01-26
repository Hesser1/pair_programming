class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id])
    if current_user
      @user_has_comment = @movie.comments.size > 0 && @movie.comments.find_by_user_id(current_user.id)
      @comment = @movie.comments.build unless @user_has_comment
    end
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailerJob.perform_later(current_user, @movie)
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporterJob.perform_later(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end
end
