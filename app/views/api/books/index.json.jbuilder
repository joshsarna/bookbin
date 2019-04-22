json.array! @books do |book|
  json.id book.id
  json.title book.title
  json.author book.author
  json.image_url book.image_url
  json.created_at book.created_at
  json.updated_at book.updated_at
end