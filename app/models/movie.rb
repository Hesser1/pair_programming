# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#
include ActiveModel::Validations

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments
  # getting plot from movie details
  def plot
    api_data['plot'] unless api_data.nil?
  end

  # getting rating from movie details
  def rating
    api_data['rating'] unless api_data.nil?
  end

  # getting poster
  def poster
    movie_details_service.poster(api_data['poster']) unless api_data.nil?
  end

  private

  def api_data
    # Calling movie_details using movie title
    @api_data ||= movie_details_service.movie_details(title)
  end

  def movie_details_service
    @movie_details_service ||= MovieDetailsService.new
  end
end
