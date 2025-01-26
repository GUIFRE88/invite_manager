require 'rails_helper'

RSpec.describe CompanyInvite, type: :model do

  describe 'associations' do
    it { should have_many(:administrators).through(:administrator_company_invites) }
    it { should belong_to(:company) }
    it { should belong_to(:invite) }
  end

  describe 'instance' do
    let(:company_invite) { create(:company_invite) }

    it 'is valid with valid attributes' do
      expect(company_invite).to be_valid
    end

    it 'is invalid without a company' do
      company_invite.company = nil
      expect(company_invite).not_to be_valid
    end

    it 'is invalid without an invite' do
      company_invite.invite = nil
      expect(company_invite).not_to be_valid
    end
  end
end
