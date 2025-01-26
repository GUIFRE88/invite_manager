require 'rails_helper'

RSpec.describe Invite, type: :model do

  describe 'associations' do
    it { should have_many(:company_invites) }
    it { should have_many(:companies).through(:company_invites) }
    it { should have_many(:administrator_company_invites) }
    it { should have_many(:administrators).through(:administrator_company_invites) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:date_completion) }
  end

  describe 'validations' do
    it 'is valid with a name and date_completion' do
      invite = Invite.new(name: 'Test Invite', date_completion: '2025-01-01')
      expect(invite).to be_valid
    end

    it 'is invalid without a name' do
      invite = Invite.new(name: nil, date_completion: '2025-01-01')
      expect(invite).to_not be_valid
      expect(invite.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without a date_completion' do
      invite = Invite.new(name: 'Test Invite', date_completion: nil)
      expect(invite).to_not be_valid
      expect(invite.errors[:date_completion]).to include("can't be blank")
    end
  end
end
