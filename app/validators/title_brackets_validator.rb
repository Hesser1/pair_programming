class TitleBracketsValidator < ActiveModel::Validator

  def initialize(movie)
    @movie = movie
  end

  def validate(movie)
    validate_movie_title(movie, "(", ")")
    validate_movie_title(movie, "{", "}")
    validate_movie_title(movie, "[", "]")
  end

  private

  def validate_movie_title(movie, open, close)
    if movie.title.count(open) != movie.title.count(close)
      movie.errors.add :base, 'has invalid title'
      return false
    end

    if check_string(movie.title, open, close) == false
      movie.errors.add :base, 'has invalid title'
      return false
    end
  end

  def check_string(title, open, close)
    start_index = title.index(open) || -1
    end_index = title.rindex(close) || -1

    return true if start_index == end_index && start_index == -1
    return false if start_index > end_index
    subtitle = title[start_index + 1...end_index]
    return check_string(subtitle, open, close) if !subtitle.empty?
    false
  end
end