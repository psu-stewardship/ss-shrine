# frozen_string_literal: true

require 'shrine/storage/s3'
require 'shrine/storage/file_system'

s3_options = {
  bucket: ENV['aws_bucket'],
  access_key_id: ENV['aws_access_key_id'],
  # endpoint: ENV['aws_endpoint'],
  # force_path_style: true,
  secret_access_key: ENV['aws_secret_access_key'],
  region: ENV['aws_region']
}


Shrine.storages = {
  # cache: Shrine::Storage::FileSystem.new('tmp', prefix: 'storage/cache'),
  cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
  store: Shrine::Storage::S3.new(**s3_options),
  derivatives: Shrine::Storage::S3.new(prefix: 'derivatives', **s3_options)
  # derivatives: Shrine::Storage::FileSystem.new('tmp', prefix: 'storage/derivatives')
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data

Shrine.plugin :presign_endpoint, presign_options: -> (request) {
  # Uppy will send the "filename" and "type" query parameters
  filename = request.params["filename"]
  type     = request.params["type"]

  {
    content_disposition:    "inline; filename=\"#{filename}\"", # set download filename
    content_type:           type,                               # set content type (defaults to "application/octet-stream")
    content_length_range:   0..(10*1024*1024),                  # limit upload size to 10 MB
  }
}