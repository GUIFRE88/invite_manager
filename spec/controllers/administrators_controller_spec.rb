require 'rails_helper'

RSpec.describe AdministratorsController, type: :controller do
  include Devise::Test::ControllerHelpers # Incluindo o helper do Devise

  let!(:administrator) { create(:administrator) }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'exibe a lista de administradores' do
      allow(ListAdministrators).to receive(:new).and_return(double(call: [administrator]))

      get :index

      expect(response).to be_successful
      expect(assigns(:administrators)).to eq([administrator])
    end
  end

  describe 'GET #edit' do
    it 'exibe a página de edição do administrador' do
      get :edit, params: { id: administrator.id }

      expect(response).to be_successful
      expect(assigns(:administrator)).to eq(administrator)
    end
  end

  describe 'PATCH #update' do
    context 'quando a atualização é bem-sucedida' do
      it 'atualiza o administrador e redireciona para a lista de administradores' do
        allow(UpdateAdministrator).to receive(:new).and_return(double(call: { success: true, administrator: administrator }))

        patch :update, params: { id: administrator.id, administrator: { email: 'new_email@example.com' } }

        expect(response).to redirect_to(administrators_path)
        expect(flash[:notice]).to eq('Administrador atualizado com sucesso.')
      end
    end

    context 'quando a atualização falha' do
      it 'renderiza a página de edição com erros' do
        allow(UpdateAdministrator).to receive(:new).and_return(double(call: { success: false, administrator: administrator }))

        patch :update, params: { id: administrator.id, administrator: { email: 'invalid_email' } }

        expect(response).to render_template(:edit)
        expect(assigns(:administrator)).to eq(administrator)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'quando a exclusão é bem-sucedida' do
      it 'exclui o administrador e redireciona para a tela de login' do
        allow(DestroyAdministrator).to receive(:new).and_return(double(call: { success: true }))

        delete :destroy, params: { id: administrator.id }

        expect(response).to redirect_to(new_administrator_session_path)
        expect(flash[:notice]).to eq('Administrador excluído com sucesso.')
      end
    end

    context 'quando a exclusão falha' do
      it 'exibe uma mensagem de erro e redireciona para a lista de administradores' do
        allow(DestroyAdministrator).to receive(:new).and_return(double(call: { success: false }))

        delete :destroy, params: { id: administrator.id }

        expect(response).to redirect_to(administrators_path)
        expect(flash[:alert]).to eq('Erro ao excluir o administrador.')
      end
    end
  end

  describe 'GET #relate_invites' do
    it 'exibe os convites relacionados ao administrador' do
      allow(RelateInvites).to receive(:new).and_return(double(call: []))

      get :relate_invites, params: { id: administrator.id }

      expect(response).to be_successful
      expect(assigns(:company_invites)).to eq([])
    end
  end

  describe 'POST #associate_invites' do
    it 'associa os convites ao administrador e redireciona' do
      invite_params = { invite1: 'value1', invite2: 'value2' }

      allow(AssociateInvites).to receive(:new).and_return(double(call: nil))

      post :associate_invites, params: { id: administrator.id, invites: invite_params }

      expect(response).to redirect_to(administrators_path)
      expect(flash[:notice]).to eq('Invitations associated successfully.')
    end
  end

  describe 'GET #invites' do
    it 'filtra e exibe os convites do administrador' do
      allow(FilterAdministratorInvites).to receive(:new).and_return(double(call: []))
      allow(FilterInvites).to receive(:new).and_return(double(call: []))

      get :invites, params: { administrator_id: administrator.id }

      expect(response).to be_successful
      expect(assigns(:administrator_invites)).to eq([])
    end
  end
end
