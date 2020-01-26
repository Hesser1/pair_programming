require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }
  let(:details) do
    { "plot": "test",
      "rating": 9.0,
      "poster": "poster" }.to_json
  end

  let(:poster) { double(:poster) }

  before :each do
    allow_any_instance_of(MovieDetailsService).to receive(:movie_details).with(anything).and_return(details)
    allow_any_instance_of(MovieDetailsService).to receive(:poster).with(anything).and_return(poster)
  end

  describe "genre list" do
    it "displays only related movies" do
      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
    end
  end
end
