# frozen_string_literal: true

json.extract! post, :id, :title, :created_at, :updated_at
json.file_data post.file_data
json.url album_post_url(post, album_id: post.album, format: :json)
