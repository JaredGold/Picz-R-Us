json.extract! listing, :id, :user_id, :type_id, :name, :duration, :price, :description, :created_at, :updated_at
json.url listing_url(listing, format: :json)
