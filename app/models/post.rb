# frozen_string_literal: true

class Post < ApplicationRecord
  include ImageUploader::Attachment(:file)

  def json_file_data
    HashWithIndifferentAccess.new(JSON.parse(file_data))
  end
end
