module API
  module V1
    class MoviesController < ApplicationController
      def show
        #get all movies as an array of id, title and return a json
        @movies = Movie.all.pluck(:id, :title)
        respond_to do |format|
          format.json { render json: JSON.pretty_generate(movies_json) }
        end
      end

      private

      #returns JSON formated list of all movies in the app
      #{
      #   "api_version": "v1",
      #   "api_call": "movies",
      #   "movies": [
      #     {
      #       "id": 1,
      #       "title": "The Dark Knight"
      #     }
      #  ]
      #}
      def movies_json
        movies = @movies.map do |movie|
          {
              id: movie[0],
              title: movie[1]
          }
        end
        {
            api_version: "v1",
            api_call: "movies",
            movies: movies
        }
      end
    end
  end
end
