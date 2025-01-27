require 'rails_helper'

RSpec.describe InvitesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let!(:administrator) { create(:administrator) }
  let!(:invite) { create(:invite) }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'displays the list of invitations' do
      get :index
      expect(response).to be_successful
      expect(assigns(:invites)).to include(invite)
    end
  end

  describe 'GET #show' do
    it 'displays the selected invitation' do
      get :show, params: { id: invite.id }
      expect(response).to be_successful
      expect(assigns(:invite)).to eq(invite)
    end
  end

  describe 'GET #new' do
    it 'displays the form to create a new invitation' do
      get :new
      expect(response).to be_successful
      expect(assigns(:invite)).to be_a_new(Invite)
    end
  end

  describe 'GET #edit' do
    it 'displays the form to edit the invitation' do
      get :edit, params: { id: invite.id }
      expect(response).to be_successful
      expect(assigns(:invite)).to eq(invite)
    end
  end

  describe 'POST #create' do
    context 'with valid data' do
      let(:valid_params) { { invite: { name: 'New Invite', date_completion: '2025-12-31' } } }

      it 'creates a new invitation and redirects to the invitation page' do
        post :create, params: valid_params
        expect(response).to redirect_to(invite_path(assigns(:invite)))
        expect(flash[:notice]).to eq('Invite was successfully created.')
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { invite: { name: '', date_completion: '2025-12-31' } } }

      it 'does not create the invitation and render the creation page' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(assigns(:invite).errors).not_to be_empty
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid data' do
      let(:valid_params) { { invite: { name: 'Updated Invite', date_completion: '2025-12-31' } } }

      it 'updates the invitation and redirects to the invitation page' do
        put :update, params: { id: invite.id, invite: valid_params[:invite] }
        expect(response).to redirect_to(invite_path(assigns(:invite)))
        expect(flash[:notice]).to eq('Invite was successfully updated.')
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { invite: { name: '', date_completion: '' } } }

      it 'does not update the invitation and render the edit page' do
        put :update, params: { id: invite.id, invite: invalid_params[:invite] }
        expect(response).to render_template(:edit)
        expect(assigns(:invite).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the invitation and redirects to the invitation list' do
      delete :destroy, params: { id: invite.id }
      expect(response).to redirect_to(invites_path)
      expect(flash[:notice]).to eq('Invite was successfully destroyed.')
    end
  end
end
