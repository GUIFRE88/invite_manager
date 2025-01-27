require 'rails_helper'

RSpec.describe AdministratorCompanyInvitesController, type: :controller do
  let!(:administrator) { create(:administrator) }
  let!(:invite) { create(:invite) }
  let!(:company_invite) { create(:company_invite, invite: invite, company: create(:company)) }

  describe 'DELETE #destroy' do
    context 'when invitation deletion is successful' do
      before do
        allow(DeleteInvite).to receive(:new).with(company_invite.id.to_s).and_return(double(call: { success: true, admin_id: administrator.id }))
      end

      it 'redirects to the admin invite page with a success message' do
        delete :destroy, params: { id: company_invite.id.to_s, administrator_id: administrator.id }

        expect(response).to redirect_to(administrator_invites_path(administrator.id))
        expect(flash[:notice]).to eq("Invite was successfully deleted.")
      end
    end

    context 'when an error occurs while deleting the invitation' do
      before do
        allow(DeleteInvite).to receive(:new).with(company_invite.id.to_s).and_return(double(call: { success: false, error: "Erro ao excluir o convite" }))
      end

      it 'redirects to the admin invite page with an error message' do
        delete :destroy, params: { id: company_invite.id.to_s, administrator_id: administrator.id }

        expect(response).to redirect_to(administrator_invites_path(administrator.id))
        expect(flash[:alert]).to eq("Erro ao excluir o convite")
      end
    end
  end
end
