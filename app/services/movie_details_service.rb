class MovieDetailsService
  def initialize
    #taking params for external url from configuration (common.rb)
    @movie_api_url = Rails.configuration.movie_api_url
    @host_api_url = Rails.configuration.host_api_url
  end
 #request to get detsils for the movie by title
  def movie_details(title)
    uri = URI.join(@movie_api_url, URI.escape(title))
    Net::HTTP.start(uri.host) do |http|
      request = Net::HTTP::Get.new(uri.request_uri)
      response = http.request request
      json_body = JSON.parse(response.body)
      Net::HTTPSuccess && json_body.key?("data") ? json_body["data"]["attributes"] : nil
    end
  end
  #creating poster img url
  def poster(name)
    URI.join(@host_api_url, name)
  end
end