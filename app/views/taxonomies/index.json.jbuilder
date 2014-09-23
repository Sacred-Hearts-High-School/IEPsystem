json.array!(@taxonomies) do |taxonomy|
  json.extract! taxonomy, :id, :name, :post_id
  json.url taxonomy_url(taxonomy, format: :json)
end
