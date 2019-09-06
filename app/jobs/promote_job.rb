# frozen_string_literal: true

class PromoteJob < ApplicationJob
  queue_as :default

  def perform(record:, name:, file_data:)
    member = Member.find(record)
    attacher = Shrine::Attacher.retrieve(model: member, name: name.to_sym, file: file_data)
    attacher.atomic_promote
  rescue Shrine::AttachmentChanged, ActiveRecord::RecordNotFound
  end
end
