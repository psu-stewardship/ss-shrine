# frozen_string_literal: true

require 'mini_magick'
require 'image_processing/mini_magick'
require 'streamio-ffmpeg'
require 'tempfile'

class ImageUploader < Shrine
  plugin :derivatives, storage: :derivatives
  plugin :add_metadata
  plugin :backgrounding
  plugin :determine_mime_type, analyzer: :marcel

  # PromoteJob takes the file from the cache store and uploads or "promotes" it to S3 storage
  Attacher.promote_block { PromoteJob.perform_later(record: record, name: name.to_s, file_data: file_data) }

  Attacher.derivatives_processor :derivatives do |original|
    if ['image/png', 'image/jpg'].include?(file.mime_type)

      processor = ImageProcessing::MiniMagick.source(original)

      {
        thumbnail: processor.resize_to_limit!(300, 300),
        service: processor.resize_to_limit!(500, 500)
      }

    elsif ['video/quicktime'].include?(file.mime_type)

      transcoded = Tempfile.new(['transcoded', '.mp4'], binmode: true)
      screenshot = Tempfile.new(['screenshot', '.jpg'], binmode: true)

      movie = FFMPEG::Movie.new(original.path)
      movie.transcode(transcoded.path)
      movie.screenshot(screenshot.path)

      [transcoded, screenshot].each(&:open) # refresh file descriptors

      {
        service: transcoded,
        thumbnail: screenshot
      }

    else
      {
        service: nil,
        thumbnail: nil
      }
    end
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
