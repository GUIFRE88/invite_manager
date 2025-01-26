require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let!(:administrator) { create(:administrator) }
  let!(:invite) { create(:invite) }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'exibe a lista de convites' do
      get :index
      expect(response).to be_successful
      expect(assigns(:invites)).to include(invite)
    end
  end

  describe 'GET #show' do
    it 'exibe o convite selecionado' do
      get :show, params: { id: invite.id }
      expect(response).to be_successful
      expect(assigns(:invite)).to eq(invite)
    end
  end

  describe 'GET #new' do
    it 'exibe o formulário para criar um novo convite' do
      get :new
      expect(response).to be_successful
      expect(assigns(:invite)).to be_a_new(Invite)
    end
  end

  describe 'GET #edit' do
    it 'exibe o formulário para editar o convite' do
      get :edit, params: { id: invite.id }
      expect(response).to be_successful
      expect(assigns(:invite)).to eq(invite)
    end
  end

  describe 'POST #create' do
    context 'com dados válidos' do
      let(:valid_params) { { invite: { name: 'New Invite', date_completion: '2025-12-31' } } }

      it 'cria um novo convite e redireciona para a página do convite' do
        post :create, params: valid_params
        expect(response).to redirect_to(invite_path(assigns(:invite)))
        expect(flash[:notice]).to eq('Invite was successfully created.')
      end
    end

    context 'com dados inválidos' do
      let(:invalid_params) { { invite: { name: '', date_completion: '2025-12-31' } } }

      it 'não cria o convite e renderiza a página de criação' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(assigns(:invite).errors).not_to be_empty
      end
    end
  end

  describe 'PUT #update' do
    context 'com dados válidos' do
      let(:valid_params) { { invite: { name: 'Updated Invite', date_completion: '2025-12-31' } } }

      it 'atualiza o convite e redireciona para a página do convite' do
        put :update, params: { id: invite.id, invite: valid_params[:invite] }
        expect(response).to redirect_to(invite_path(assigns(:invite)))
        expect(flash[:notice]).to eq('Invite was successfully updated.')
      end
    end

    context 'com dados inválidos' do
      let(:invalid_params) { { invite: { name: '', date_completion: '' } } }

      it 'não atualiza o convite e renderiza a página de edição' do
        put :update, params: { id: invite.id, invite: invalid_params[:invite] }
        expect(response).to render_template(:edit)
        expect(assigns(:invite).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deleta o convite e redireciona para a lista de convites' do
      delete :destroy, params: { id: invite.id }
      expect(response).to redirect_to(invites_path)
      expect(flash[:notice]).to eq('Invite was successfully destroyed.')
    end
  end
end
