# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/show', type: :view do
  before do
    @post = assign(:post, Post.create!(album: Album.create))
  end

  it 'renders attributes in <p>' do
    render
  end
end
