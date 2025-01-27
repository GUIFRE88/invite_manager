require 'rails_helper'

RSpec.describe RelateInvitesForCompany, type: :service do
  describe '#call' do
    let!(:company) { create(:company) }
    let!(:invite1) { create(:invite) }
    let!(:invite2) { create(:invite) }
    let!(:invite3) { create(:invite) }
    
    before do
      company.invites << invite1
      company.invites << invite2
    end

    context 'when there are company-related invitations' do
      it 'returns both company-related and non-company-related invitations' do
        service = RelateInvitesForCompany.new(company)
        result = service.call

        expect(result).to contain_exactly(invite1, invite2, invite3)
        expect(result.count).to eq(3)
      end
    end

    context 'when there are related invitations and new unrelated invitations' do
      it 'returns all invitations, ensuring they are unique' do
        service = RelateInvitesForCompany.new(company)
        result = service.call

        expect(result).to contain_exactly(invite1, invite2, invite3)
        expect(result.count).to eq(3)
      end
    end
  end
end
