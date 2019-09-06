# frozen_string_literal: true

class Post < ApplicationRecord
  include ImageUploader::Attachment(:file)

  def file_data_json
    JSON.parse(file_data)
  end
end
