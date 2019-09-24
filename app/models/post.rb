# frozen_string_literal: true

class Post < ApplicationRecord
  include ImageUploader::Attachment(:file)

  belongs_to :album

  has_paper_trail

  def file_data
    HashWithIndifferentAccess.new(super)
  end

  def display_name
    title || file_data.fetch(:metadata, {}).fetch(:filename, '[na]')
  end

  private

    def filename
      @filename ||= file_data.fetch(:metadata, {}).fetch(:filename, '[na]')
    end
end
