# frozen_string_literal: true

require 'mini_magick'
require 'image_processing/mini_magick'

class ImageUploader < Shrine
  plugin :derivatives, storage: :derivatives
  plugin :add_metadata

  Attacher.derivatives_processor :thumbnails do |original|
    processor = ImageProcessing::MiniMagick.source(original)

    {
      small: processor.resize_to_limit!(300, 300),
      medium: processor.resize_to_limit!(500, 500),
      large: processor.resize_to_limit!(800, 800)
    }
  end

  add_metadata :exif do |io, context|
    if context[:derivative].blank?
      Shrine.with_file(io) do |file|
        MiniMagick::Image.new(file.path).exif
      rescue MiniMagick::Error
        Rails.logger.warn("#{file.path} is not a valid image")
      end
    end
  end
end
