# frozen_string_literal: true

require 'shrine/storage/s3'
require 'shrine/storage/file_system'

PROMOTION_LOCATION = 'store'

s3_options = {
  bucket: ENV['aws_bucket'],
  access_key_id: ENV['aws_access_key_id'],
  secret_access_key: ENV['aws_secret_access_key'],
  region: ENV['aws_region']
}

if ENV['s3_endpoint']
  s3_options[:endpoint] = ENV['s3_endpoint']
  s3_options[:force_path_style] = true
end

Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
  ::PROMOTION_LOCATION.to_sym => Shrine::Storage::S3.new(**s3_options),
  derivatives: Shrine::Storage::S3.new(prefix: 'derivatives', **s3_options)
}

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :uppy_s3_multipart
