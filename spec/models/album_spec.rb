# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Album, type: :model do
  describe 'table' do
    it { is_expected.to have_db_column(:title) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:posts) }
  end
end
