# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :work
  include ImageUploader::Attachment(:file)
end
