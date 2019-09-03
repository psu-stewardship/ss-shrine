# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Member, type: :model do
  subject(:member) { described_class.new(original_filename: 'myfile.txt') }

  describe '#original_filename' do
    its(:original_filename) { is_expected.to eq('myfile.txt') }
  end

  describe '#work_id' do
    its(:work_id) { is_expected.to be_nil }
  end
end
