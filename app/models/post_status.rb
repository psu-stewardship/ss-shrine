# frozen_string_literal: true

class PostStatus
  attr_reader :post

  # @param [Post] post
  def initialize(post)
    @post = post
  end

  def promoted?
    post.json_file_data.fetch(:storage, nil) == ::PROMOTION_LOCATION
  end

  def derived?
    post.json_file_data.fetch(:derivatives, {}).any?
  end
end
