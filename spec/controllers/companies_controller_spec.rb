require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  include Devise::Test::ControllerHelpers
  let!(:administrator) { create(:administrator) }
  let!(:company) { create(:company) }

  before do
    sign_in administrator
  end

  describe 'GET #index' do
    it 'exibe a lista de empresas' do
      get :index
      expect(response).to be_successful
      expect(assigns(:companies)).to include(company)
    end
  end

  describe 'GET #show' do
    it 'exibe a empresa selecionada' do
      get :show, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'GET #new' do
    it 'exibe o formulário para criar uma nova empresa' do
      get :new
      expect(response).to be_successful
      expect(assigns(:company)).to be_a_new(Company)
    end
  end

  describe 'POST #create' do
    context 'com dados válidos' do
      let(:valid_params) { { company: { name: 'New Company' } } }

      it 'cria uma nova empresa e redireciona para a página da empresa' do
        post :create, params: valid_params
        expect(response).to redirect_to(company_path(assigns(:company)))
        expect(flash[:notice]).to eq('Company was successfully created.')
      end
    end

    context 'com dados inválidos' do
      let(:invalid_params) { { company: { name: '' } } }

      it 'não cria a empresa e renderiza a página de criação' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(assigns(:company).errors).not_to be_empty
      end
    end
  end

  describe 'GET #edit' do
    it 'exibe o formulário para editar a empresa' do
      get :edit, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:company)).to eq(company)
    end
  end

  describe 'PUT #update' do
    context 'com dados válidos' do
      let(:valid_params) { { company: { name: 'Updated Company' } } }

      it 'atualiza a empresa e redireciona para a página da empresa' do
        put :update, params: { id: company.id, company: valid_params[:company] }
        expect(response).to redirect_to(company_path(assigns(:company)))
        expect(flash[:notice]).to eq('Company was successfully updated.')
      end
    end

    context 'com dados inválidos' do
      let(:invalid_params) { { company: { name: '' } } }

      it 'não atualiza a empresa e renderiza a página de edição' do
        put :update, params: { id: company.id, company: invalid_params[:company] }
        expect(response).to render_template(:edit)
        expect(assigns(:company).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deleta a empresa e redireciona para a lista de empresas' do
      delete :destroy, params: { id: company.id }
      expect(response).to redirect_to(companies_path)
      expect(flash[:notice]).to eq('Company was successfully destroyed.')
    end
  end

  describe 'GET #relate_invites' do
    it 'exibe os convites relacionados à empresa' do
      allow(RelateInvitesForCompany).to receive(:new).and_return(double(call: []))
      get :relate_invites, params: { id: company.id }
      expect(response).to be_successful
      expect(assigns(:invites)).to eq([])
    end
  end

  describe 'POST #associate_invites' do
    context 'com invites válidos' do
      let(:invite_ids) { [1, 2, 3] }

      it 'associa os convites com sucesso' do
        post :associate_invites, params: { id: company.id, invite_ids: invite_ids }
        expect(response).to redirect_to(company_path(company))
        expect(flash[:notice]).to eq('Invites successfully associated.')
      end
    end

    context 'sem invites' do
      it 'não associa convites e redireciona para a página da empresa' do
        post :associate_invites, params: { id: company.id, invite_ids: [] }
        expect(response).to redirect_to(company_path(company))
        expect(flash[:notice]).to eq('Invites successfully associated.')
      end
    end
  end
end
