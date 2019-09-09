# frozen_string_literal: true

class PromoteJob < ApplicationJob
  queue_as :default

  def perform(record:, name:, file_data:)
    attacher = Shrine::Attacher.retrieve(model: record, name: name.to_sym, file: file_data)
    10.times do
      Rails.logger.warn("I'm resting...")
      sleep(1)
    end
    record.file_derivatives!(:thumbnails)
    attacher.atomic_promote
  rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
  end
end
