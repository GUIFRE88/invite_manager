require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let!(:administrator) { create(:administrator) }
  let!(:company) { create(:company) }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'displays the list of companies' do
      get :index
      expect(response).to be_successful
      expect(assigns(:companies)).to include(company)
    end
  end

  describe 'GET #show' do
    it 'displays the selected company' do
      get :show, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'GET #new' do
    it 'displays the form to create a new company' do
      get :new
      expect(response).to be_successful
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'POST #create' do
    context 'with valid data' do
      let(:valid_params) { { company: { name: 'New Company' } } }

      it 'create a new company and redirect to the company page' do
        post :create, params: valid_params
        expect(response).to redirect_to(company_path(assigns(:company)))
        expect(flash[:notice]).to eq('Company was successfully created.')
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { company: { name: '' } } }

      it 'does not create the company and renders the creation page' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(assigns(:company).errors).not_to be_empty
      end
    end
  end

  describe 'GET #edit' do
    it 'displays the form to edit the company' do
      get :edit, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'PUT #update' do
    context 'with valid data' do
      let(:valid_params) { { company: { name: 'Updated Company' } } }

      it 'updates the company and redirects to the company page' do
        put :update, params: { id: company.id, company: valid_params[:company] }
        expect(response).to redirect_to(company_path(assigns(:company)))
        expect(flash[:notice]).to eq('Company was successfully updated.')
      end
    end

    context 'with invalid data' do
      let(:invalid_params) { { company: { name: '' } } }

      it 'does not update the company and render the edit page' do
        put :update, params: { id: company.id, company: invalid_params[:company] }
        expect(assigns(:company).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'delete the company and redirect to the company list' do
      delete :destroy, params: { id: company.id }
      expect(response).to redirect_to(companies_path)
      expect(flash[:notice]).to eq('Company was successfully destroyed.')
    end
  end

  describe 'GET #relate_invites' do
    it 'displays company-related invitations' do
      allow(RelateInvitesForCompany).to receive(:new).and_return(double(call: []))
      get :relate_invites, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:invites)).to eq([])
    end
  end

  describe 'POST #associate_invites' do
    context 'with valid invites' do
      let(:invite_ids) { [1, 2, 3] }

      it 'successfully associates invitations' do
        post :associate_invites, params: { id: company.id, invite_ids: invite_ids }
        expect(response).to redirect_to(company_path(company))
        expect(flash[:notice]).to eq('Invites successfully associated.')
      end
    end

    context 'sem invites' do
      it 'does not associate invitations and redirects to the company page' do
        post :associate_invites, params: { id: company.id, invite_ids: [] }
        expect(response).to redirect_to(company_path(company))
        expect(flash[:notice]).to eq('Invites successfully associated.')
      end
    end
  end
end
