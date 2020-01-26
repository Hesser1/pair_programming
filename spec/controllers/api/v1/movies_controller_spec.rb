require "rails_helper"

describe API::V1::MoviesController, :type => :request do

  let(:result) do
    {
        api_version: "v1",
        api_call: "movies",
        movies: [
            {id: 1, title: "Foo"},
            {id: 2, title: "Bar"}
        ]
    }.to_json
  end
  it 'makes simple check for show' do
    create(:movie, title: "Foo")
    create(:movie, title: "Bar")

    get "/api/v1/movies"

    expect(response.status).to eq(200)
    expect(JSON.parse(response.body)).to eq(JSON.parse(result))
    expect(response.content_type).to eq "application/json"
  end
end