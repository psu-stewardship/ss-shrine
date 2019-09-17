# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'posts/index', type: :view do
  before do
    assign(:posts, [
             Post.create!(album: Album.create),
             Post.create!(album: Album.create)
           ])
  end

  it 'renders a list of posts' do
    render
  end
end
