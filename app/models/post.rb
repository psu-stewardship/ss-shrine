# frozen_string_literal: true

class Post < ApplicationRecord
  include ImageUploader::Attachment(:file)
end
