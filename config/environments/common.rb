Rails.application.configure do
  # storing common config params for dev, test and prod environment
  config.movie_api_url = "https://pairguru-api.herokuapp.com/api/v1/movies/"
  config.host_api_url = "https://pairguru-api.herokuapp.com"
end