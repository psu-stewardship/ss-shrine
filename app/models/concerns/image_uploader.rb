# frozen_string_literal: true

require 'mini_magick'
require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :processing
  plugin :versions
  plugin :add_metadata

  process(:store) do |io, _context|
    versions = { original: io }

    io.download do |original|
      pipeline = ImageProcessing::MiniMagick.source(original)

      versions[:large]  = pipeline.resize_to_limit!(800, 800)
      versions[:medium] = pipeline.resize_to_limit!(500, 500)
      versions[:small]  = pipeline.resize_to_limit!(300, 300)
    end

    versions
  end

  add_metadata :exif do |io, _context|
    Shrine.with_file(io) do |file|
      MiniMagick::Image.new(file.path).exif
    rescue MiniMagick::Error
      Rails.logger.warn("#{file.path} is not a valid image")
    end
  end
end
