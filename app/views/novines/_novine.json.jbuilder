json.extract! novine, :id, :user_id, :title, :name, :body, :publish, :created_at, :updated_at
json.url novine_url(novine, format: :json)
json.body novine.body.to_s
