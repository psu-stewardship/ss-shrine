# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'albums/index', type: :view do
  before do
    assign(:albums, [
             Album.create!,
             Album.create!
           ])
  end

  it 'renders a list of albums' do
    render
  end
end
