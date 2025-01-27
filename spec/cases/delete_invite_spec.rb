require 'rails_helper'

RSpec.describe DeleteInvite, type: :service do
  describe '#call' do
    context 'when the invitation exists' do
      let!(:admin_invite) { create(:administrator_company_invite) }
      let(:admin_invite_id) { admin_invite.id }

      it 'successfully deletes the invitation and returns the admin id' do
        service = DeleteInvite.new(admin_invite_id)

        result = service.call

        expect(result[:success]).to be true
        expect(result[:admin_id]).to eq(admin_invite.administrator_id)
        expect(AdministratorCompanyInvite.exists?(admin_invite_id)).to be false
      end
    end

    context 'when the invitation does not exist' do
      let(:non_existing_admin_invite_id) { 999 }

      it 'returns an error' do
        service = DeleteInvite.new(non_existing_admin_invite_id)

        result = service.call

        expect(result[:success]).to be false
        expect(result[:error]).to eq("Invite not found.")
      end
    end
  end
end
