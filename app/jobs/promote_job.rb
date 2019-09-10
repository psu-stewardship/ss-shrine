# frozen_string_literal: true

class PromoteJob < ApplicationJob
  queue_as :default

  def perform(record:, name:, file_data:)
    attacher = Shrine::Attacher.retrieve(model: record, name: name.to_sym, file: file_data)
    record.file_derivatives!(:derivatives)
    attacher.atomic_promote
  rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
  end
end
