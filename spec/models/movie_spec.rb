require "rails_helper"

describe Movie, type: :model do
  let(:movie) { build(:movie) }
  let(:poster) { "godfather.jpg" }
  let(:rating) { 9.2 }
  let(:plot) do
    "The aging patriarch of an organized crime dynasty transfers control
     of his clandestine empire to his reluctant son."
  end

  it "movie have a poster" do
    movie.title = "Godfather"
    expect(movie.poster.to_s).to end_with(poster)
  end

  it "movie have a plot" do
    movie.title = "Godfather"
    expect(movie.plot).to eq(plot.squish)
  end

  it "movie have a plot" do
    movie.title = "Godfather"
    expect(movie.rating).to eq(rating)
  end

  it "no movie, no poster" do
    movie.title = "Godfather 2"
    expect(movie.poster.to_s).to eq("")
  end

  it "no movie, no ratings" do
    movie.title = "Godfather 2"
    expect(movie.rating.to_s).to eq("")
  end

  it "no movie, no plot" do
    movie.title = "Godfather 2"
    expect(movie.plot.to_s).to eq("")
  end
end