require 'rails_helper'

RSpec.describe Company, type: :model do

  describe 'associations' do
    it { should have_many(:invites).through(:company_invites) }
    it { should have_many(:administrator_company_invites) }
    it { should have_many(:administrators).through(:administrator_company_invites) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'instance' do
    let(:company) { create(:company) }

    it 'is valid with valid attributes' do
      expect(company).to be_valid
    end

    it 'is invalid without a name' do
      company.name = nil
      expect(company).not_to be_valid
    end

  end
end
