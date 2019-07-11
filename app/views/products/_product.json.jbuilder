json.extract! product, :id, :name, :description, :price, :sold, :created_at, :updated_at
json.url product_url(product, format: :json)
