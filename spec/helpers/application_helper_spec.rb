require 'spec_helper'
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  let(:key) { 'success' }
  it 'returns success' do
    expect(helper.flash_message_class(key)).to eq 'success'
  end
  context 'with danger message' do
    let(:key) { 'error' }
    it 'returns danger' do
      expect(helper.flash_message_class(key)).to eq 'danger'
    end
  end
  context 'with warning message' do
    let(:key) { 'notice' }
    it 'returns warning' do
      expect(helper.flash_message_class(key)).to eq 'warning'
    end
  end
end
