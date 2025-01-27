RSpec.describe RelateInvites, type: :service do
  describe '#call' do
    let!(:administrator) { create(:administrator) }
    let!(:company1) { create(:company) }
    let!(:company2) { create(:company) }
    let!(:invite1) { create(:invite) }
    let!(:invite2) { create(:invite) }
    let!(:invite3) { create(:invite) }
    
    before do
      create(:company_invite, company: company1, invite: invite1)
      create(:company_invite, company: company2, invite: invite2)
    end

    context 'when there are invitations already associated with the administrator' do
      before do
        create(:administrator_company_invite, administrator: administrator, invite: invite1)
      end

      it 'returns only invites not associated with the admin' do
        service = RelateInvites.new(administrator)
        result = service.call
        invite_ids = result.map(&:invite_id)

        expect(invite_ids).to include(invite2.id)
      end
    end

    context 'when there are no invitations associated with the administrator' do
      it 'returns all company invites that have not been associated with the admin' do
        service = RelateInvites.new(administrator)
        result = service.call

        invite_ids = result.map(&:invite_id)

        expect(invite_ids).to include(invite1.id)
      end
    end

    context 'when there are no company-related invitations' do
      it 'returns only invitations not associated with the administrator' do
        AdministratorCompanyInvite.destroy_all
        
        service = RelateInvites.new(administrator)
        result = service.call

        invite_ids = result.map(&:invite_id)

        expect(invite_ids).to include(invite1.id)
      end
    end
  end
end
