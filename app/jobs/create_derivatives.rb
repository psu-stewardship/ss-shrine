# frozen_string_literal: true

class CreateDerivatives < ApplicationJob
  queue_as :default

  def perform(record)
    post = Post.find(record)
    post.file_derivatives!(:thumbnails)
    post.save
  end
end
