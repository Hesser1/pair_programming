require "rails_helper"

describe MoviesController, type: :controller do
  ActiveJob::Base.queue_adapter = :test
  let(:user) { create(:user) }
  let(:file_path) { "tmp/movies.csv" }

  it "should enqueue MoviesExporter for every created product" do
    genre = create(:genre, name: "Bar")
    movie = create(:movie, title: "Foo", genre: genre)
    sign_in user
    post :export
    expect(MovieExporterJob).to have_been_enqueued.with(user, file_path)
  end
end