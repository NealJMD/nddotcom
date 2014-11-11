module CategoriesHelper

  def color_from_string query
    return '#'+query.hash.to_s(16).slice(1,6)
  end

end
