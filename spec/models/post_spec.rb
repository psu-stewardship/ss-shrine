# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'table' do
    it { is_expected.to have_db_column(:album_id) }
    it { is_expected.to have_db_index(:album_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:album) }
  end
end
