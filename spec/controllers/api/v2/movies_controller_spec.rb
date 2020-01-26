require "rails_helper"

describe API::V2::MoviesController, :type => :request do

  let(:result) do
    {
        api_version: "v2",
        api_call: "movies",
        movies: [
            {id: 1, title: "Foo", genre: {
                id: 1,
                name: "Foo",
                count_movies: 1
            }},
            {id: 2, title: "Bar", genre: {
                id: 2,
                name: "Bar",
                count_movies: 1
            }}
        ]
    }.to_json
  end
  it 'makes simple check for show' do
    genre_foo = create(:genre, name: "Foo")
    genre_bar = create(:genre, name: "Bar")

    create(:movie, title: "Foo", genre: genre_foo)
    create(:movie, title: "Bar", genre: genre_bar)

    get "/api/v2/movies"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq(JSON.parse(result))
    expect(response.content_type).to eq "application/json"
  end
end