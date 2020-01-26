require "rails_helper"

describe MovieDetailsService do

  subject { described_class.new }
  let(:name) { "foo" }
  let(:url) { "https://pairguru-api.herokuapp.com/#{name}" }
  let(:title) { "Godfather" }
  let(:movie_details) do
    { title: "Godfather",
      plot: "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son.",
      rating: 9.2,
      poster: "/godfather.jpg" }
  end
  let(:fake_title) { "Godfather1" }
  context 'poster' do
    it 'returns existing poster' do
      expect(subject.poster(name).to_s).to eq url
    end
  end

  context 'movie_details' do
    it 'returns existing details' do
      expect(subject.movie_details(title).to_json).to eq(movie_details.to_json)
    end

    it 'returns no details for not existing movie' do
      expect(subject.movie_details(fake_title).to_s).to eq("")
    end
  end

end