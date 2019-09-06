# frozen_string_literal: true

class CreateDerivatives < ApplicationJob
  queue_as :default

  def perform(record)
    member = Member.find(record)
    member.file_derivatives!(:thumbnails)
    member.save
  end
end
