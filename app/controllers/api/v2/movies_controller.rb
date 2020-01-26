module API
  module V2
    class MoviesController < ApplicationController
      def show
        #get all movies and return a json
        @movies = Movie.all
        respond_to do |format|
          format.json { render json: JSON.pretty_generate(movies_json) }
        end
      end

      private

      #returns JSON formated list of all movies in the app
      #{
      #   "api_version": "v2",
      #   "api_call": "movies",
      #   "movies": [
      #     {
      #       "id": 1,
      #       "title": "The Dark Knight",
      #       "genre": {
      #         "id": 8,
      #         "name": "Western",
      #         "count_movies": 8
      #       }
      #     }
      #  ]
      #}
      def movies_json
        movies = @movies.map do |movie|
          {
              id: movie.id,
              title: movie.title,
              genre: {
                  id: movie.genre.id,
                  name: movie.genre.name,
                  count_movies: movie.genre.movies.count
              }
          }
        end
        {
            api_version: "v2",
            api_call: "movies",
            movies: movies
        }
      end
    end
  end
end
