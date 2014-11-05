json.array!(@posts) do |post|
  json.extract! post, :id, :category_id, :body, :title, :published_at
  json.url post_url(post, format: :json)
end
