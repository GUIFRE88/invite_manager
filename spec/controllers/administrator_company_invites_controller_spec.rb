require 'rails_helper'

RSpec.describe AdministratorCompanyInvitesController, type: :controller do
  let!(:administrator) { create(:administrator) }
  let!(:invite) { create(:invite) }
  let!(:company_invite) { create(:company_invite, invite: invite, company: create(:company)) }

  describe 'DELETE #destroy' do
    context 'quando a exclusão do convite é bem-sucedida' do
      before do
        allow(DeleteInvite).to receive(:new).with(company_invite.id.to_s).and_return(double(call: { success: true, admin_id: administrator.id }))
      end

      it 'redireciona para a página de convites do administrador com uma mensagem de sucesso' do
        delete :destroy, params: { id: company_invite.id.to_s, administrator_id: administrator.id }

        expect(response).to redirect_to(administrator_invites_path(administrator.id))
        expect(flash[:notice]).to eq("Invite was successfully deleted.")
      end
    end

    context 'quando ocorre um erro na exclusão do convite' do
      before do
        allow(DeleteInvite).to receive(:new).with(company_invite.id.to_s).and_return(double(call: { success: false, error: "Erro ao excluir o convite" }))
      end

      it 'redireciona para a página de convites do administrador com uma mensagem de erro' do
        delete :destroy, params: { id: company_invite.id.to_s, administrator_id: administrator.id }

        expect(response).to redirect_to(administrator_invites_path(administrator.id))
        expect(flash[:alert]).to eq("Erro ao excluir o convite")
      end
    end
  end
end
