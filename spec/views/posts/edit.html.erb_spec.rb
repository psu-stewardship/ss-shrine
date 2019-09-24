# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/edit', type: :view do
  before do
    @post = assign(:post, Post.create!(album: Album.create))
  end

  it 'renders the edit post form' do
    render

    assert_select 'form[action=?][method=?]', album_post_path(@post, album_id: @post.album), 'post' do
    end
  end
end
