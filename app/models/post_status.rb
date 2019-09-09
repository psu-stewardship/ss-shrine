# frozen_string_literal: true

class PostStatus
  attr_reader :post

  # @param [Post] post
  def initialize(post)
    @post = post
  end

  def completed?
    promoted? && derived?
  end

  def promoted?
    data.fetch(:storage, nil) == ::PROMOTION_LOCATION
  end

  def derived?
    data.fetch(:derivatives, {}).any?
  end

  private

  def data
    @data ||= post.json_file_data
  end
end
