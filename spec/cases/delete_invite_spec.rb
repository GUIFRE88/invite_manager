require 'rails_helper'

RSpec.describe DeleteInvite, type: :service do
  describe '#call' do
    context 'quando o convite existe' do
      let!(:admin_invite) { create(:administrator_company_invite) }
      let(:admin_invite_id) { admin_invite.id }

      it 'deleta o convite com sucesso e retorna o id do administrador' do
        service = DeleteInvite.new(admin_invite_id)

        result = service.call

        expect(result[:success]).to be true
        expect(result[:admin_id]).to eq(admin_invite.administrator_id)
        expect(AdministratorCompanyInvite.exists?(admin_invite_id)).to be false
      end
    end

    context 'quando o convite não existe' do
      let(:non_existing_admin_invite_id) { 999 }

      it 'retorna um erro' do
        service = DeleteInvite.new(non_existing_admin_invite_id)

        result = service.call

        expect(result[:success]).to be false
        expect(result[:error]).to eq("Invite not found.")
      end
    end
  end
end
