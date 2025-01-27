require 'rails_helper'

RSpec.describe InviteRepository, type: :repository do
  let(:administrator) { create(:administrator) }
  let(:company) { create(:company) }
  let(:invite) { create(:invite) }
  let(:repository) { InviteRepository.new(invite) }

  describe '#update' do
    let(:params) { { name: 'New Invite Name' } }

    it 'updates the invite with new params' do
      expect(repository.update(params)).to be_truthy
      expect(invite.reload.name).to eq('New Invite Name')
    end
  end


  describe '#relate_invites_for_company' do
    let!(:company_invite) { create(:company_invite, company: company, invite: invite) }
    let!(:other_invite) { create(:invite) }

    it 'returns invites related to the company and those not yet related' do
      invites = repository.relate_invites_for_company(company)
      expect(invites).to include(company_invite.invite)
      expect(invites).to include(other_invite)
    end
  end

  describe '#list_invites' do
    let!(:invite1) { create(:invite) }
    let!(:invite2) { create(:invite) }

    it 'returns all invites' do
      invites = repository.index
      expect(invites).to include(invite1, invite2)
    end
  end

  describe '#destroy!' do
    it 'destroys the invite' do
      invite = create(:invite)
      repository = InviteRepository.new(invite)
      expect { repository.destroy! }.to change { Invite.count }.by(-1)
      expect(Invite.exists?(invite.id)).to be_falsey
    end
  end

  describe '#delete' do
    let!(:admin_invite) { create(:administrator_company_invite, administrator: administrator, invite: invite) }

    it 'deletes an invite and returns success' do
      result = repository.delete(admin_invite.id)
      expect(result[:success]).to be(true)
      expect { admin_invite.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'returns error if invite not found' do
      result = repository.delete(999)
      expect(result[:success]).to be(false)
      expect(result[:error]).to eq('Invite not found.')
    end
  end
end
