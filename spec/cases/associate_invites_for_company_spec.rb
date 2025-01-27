require 'rails_helper'

RSpec.describe AssociateInvitesForCompany, type: :service do
  let!(:company) { create(:company) }
  let!(:invite1) { create(:invite) }
  let!(:invite2) { create(:invite) }
  let!(:invite3) { create(:invite) }

  before do
    company.invites << invite1
    company.invites << invite2
  end

  describe '#call' do
    context 'when an invitation is removed' do
      it 'remove company invitation' do
        invite_ids = [invite1.id.to_s]

        service = AssociateInvitesForCompany.new(company, invite_ids)
        service.call

        expect(company.invites).to include(invite1)
        expect(company.invites).not_to include(invite2)
      end
    end

    context 'when new invitations are added' do
      it 'add invitations to the company' do
        invite_ids = [invite1.id.to_s, invite2.id.to_s, invite3.id.to_s]

        service = AssociateInvitesForCompany.new(company, invite_ids)
        service.call

        expect(company.invites).to include(invite1, invite2, invite3)
      end
    end

    context 'when the same invitation is already associated' do
      it 'does not add duplicate invitations' do
        invite_ids = [invite1.id.to_s, invite2.id.to_s]

        service = AssociateInvitesForCompany.new(company, invite_ids)
        service.call

        expect(company.invites.count).to eq(2)
      end
    end
  end
end
