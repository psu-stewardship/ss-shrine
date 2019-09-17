# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'albums/show', type: :view do
  before do
    @album = assign(:album, Album.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
