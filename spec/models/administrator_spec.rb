require 'rails_helper'

RSpec.describe Administrator, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

  describe 'associations' do
    it { should have_many(:administrator_company_invites) }
    it { should have_many(:companies).through(:administrator_company_invites) }
    it { should have_many(:invites).through(:administrator_company_invites) }
  end

  describe 'instance' do
    let(:administrator) { create(:administrator) }

    it 'is valid with valid attributes' do
      expect(administrator).to be_valid
    end

    it 'is invalid without an email' do
      administrator.email = nil
      expect(administrator).not_to be_valid
    end

  end
end
