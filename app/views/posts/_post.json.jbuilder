# frozen_string_literal: true

json.extract! post, :id, :title, :created_at, :updated_at
json.file_data post.file_data
json.url post_url(post, format: :json)
