# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Work, type: :model do
  subject(:work) { described_class.new(title: 'Sample Work', description: 'A description of my work') }

  describe '#title' do
    its(:title) { is_expected.to eq('Sample Work') }
  end

  describe '#description' do
    its(:description) { is_expected.to eq('A description of my work') }
  end
end
