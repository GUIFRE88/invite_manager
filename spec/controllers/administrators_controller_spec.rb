require 'rails_helper'

RSpec.describe AdministratorsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:administrator) { create(:administrator) }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'display the list of administrators' do
      allow(ListAdministrators).to receive(:new).and_return(double(call: [administrator]))

      get :index

      expect(response).to be_successful
      expect(assigns(:administrators)).to eq([administrator])
    end
  end

  describe 'GET #edit' do
    it 'displays the administrator edit page' do
      get :edit, params: { id: administrator.id }

      expect(response).to be_successful
      expect(assigns(:administrator)).to eq(administrator)
    end
  end

  describe 'PATCH #update' do
    context 'when the update is successful' do
      it 'updates the administrator and redirects to the administrator list' do
        allow(UpdateAdministrator).to receive(:new).and_return(double(call: { success: true, administrator: administrator }))

        patch :update, params: { id: administrator.id, administrator: { email: 'new_email@example.com' } }

        expect(response).to redirect_to(administrators_path)
        expect(flash[:notice]).to eq('Administrator updated successfully.')
      end
    end

    context 'when the update fails' do
      it 'renders edit page with errors' do
        allow(UpdateAdministrator).to receive(:new).and_return(double(call: { success: false, administrator: administrator }))

        patch :update, params: { id: administrator.id, administrator: { email: 'invalid_email' } }

        expect(response).to render_template(:edit)
        expect(assigns(:administrator)).to eq(administrator)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when deletion is successful' do
      it 'deletes the administrator and redirects to the login screen' do
        allow(DestroyAdministrator).to receive(:new).and_return(double(call: { success: true }))

        delete :destroy, params: { id: administrator.id }

        expect(response).to redirect_to(new_administrator_session_path)
        expect(flash[:notice]).to eq('Administrator successfully deleted.')
      end
    end

    context 'when deletion fails' do
      it 'displays an error message and redirects to the administrators list' do
        allow(DestroyAdministrator).to receive(:new).and_return(double(call: { success: false }))

        delete :destroy, params: { id: administrator.id }

        expect(response).to redirect_to(administrators_path)
        expect(flash[:alert]).to eq('Error deleting administrator.')
      end
    end
  end

  describe 'GET #relate_invites' do
    it 'displays invitations related to the administrator' do
      allow(RelateInvites).to receive(:new).and_return(double(call: []))

      get :relate_invites, params: { id: administrator.id }

      expect(response).to be_successful
      expect(assigns(:company_invites)).to eq([])
    end
  end

  describe 'POST #associate_invites' do
    it 'associates invitations with the administrator and redirects' do
      invite_params = { invite1: 'value1', invite2: 'value2' }

      allow(AssociateInvites).to receive(:new).and_return(double(call: nil))

      post :associate_invites, params: { id: administrator.id, invites: invite_params }

      expect(response).to redirect_to(administrators_path)
      expect(flash[:notice]).to eq('Invitations associated successfully.')
    end
  end

  describe 'GET #invites' do
    it 'filters and displays admin invitations' do
      allow(FilterAdministratorInvites).to receive(:new).and_return(double(call: []))
      allow(FilterInvites).to receive(:new).and_return(double(call: []))

      get :invites, params: { administrator_id: administrator.id }

      expect(response).to be_successful
      expect(assigns(:administrator_invites)).to eq([])
    end
  end
end
