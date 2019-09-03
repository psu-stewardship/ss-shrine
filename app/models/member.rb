# frozen_string_literal: true

class Member < ApplicationRecord
  belongs_to :work
  include Shrine::Attachment.new(:file)
end
