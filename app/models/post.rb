# frozen_string_literal: true

class Post < ApplicationRecord
  include ImageUploader::Attachment(:file)

  belongs_to :album

  def file_data
    HashWithIndifferentAccess.new(super)
  end
end
