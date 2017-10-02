require 'spec_helper'
require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(email: 'test@example.com', full_name: 'Bob Ross', admin: false) { |u| u.save!(validate: false) }
  end
  let(:reimbursement_request) { ReimbursementRequest.create(certifier: user) }

  it 'has a full_name_label' do
    expect(user.full_name_label).to eq user.full_name
  end

  it 'has an email' do
    expect(user.email).to be_kind_of String
    expect(user.email).to eq "test@example.com"
  end

  it 'can manage a reimbursement request' do
    expect(user.can_manage(reimbursement_request)).to be_truthy
  end

  context 'given some cas extra attributes' do
    let(:attributes) { { email: 'test@test.com', osupidm: 123123123, fullname: 'Bob Ross' } }
    it 'sets attributes from CAS' do
      user.cas_extra_attributes = attributes
      expect(user.email).to eq attributes[:email]
      expect(user.pidm).to eq attributes[:osupidm]
      expect(user.full_name_label).to eq attributes[:fullname]
    end
  end

  describe 'required fields' do
    context 'without required fields specified' do
      it 'does not have all required fields' do
        expect(user.required_fields?).to be_falsey
      end
    end
    context 'with required fields specified' do
      let(:user) do
        User.new(
          email: 'test@example.com',
          admin: false,
          osu_id: '123123123',
          activity_code: '1234',
          organization: Organization.create) { |u| u.save!(validate: false) }
      end
      it 'does have all required fields' do
        expect(user.required_fields?).to be_truthy
      end
    end
  end
end
