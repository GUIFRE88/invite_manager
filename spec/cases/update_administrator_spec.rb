require 'rails_helper'

RSpec.describe UpdateAdministrator, type: :service do
  describe '#call' do
    let!(:administrator) { create(:administrator, email: "old_email@example.com") }

    context 'quando a atualização é bem-sucedida' do
      let(:valid_params) { { email: "new_email@example.com" } }

      it 'atualiza o administrador com os novos parâmetros' do
        service = UpdateAdministrator.new(administrator, valid_params)

        result = service.call

        expect(result[:success]).to be_truthy
        expect(result[:administrator].email).to eq("new_email@example.com")
      end
    end

    context 'quando a atualização falha' do
      let(:invalid_params) { { email: nil } }

      it 'não atualiza o administrador e retorna os erros' do
        service = UpdateAdministrator.new(administrator, invalid_params)

        result = service.call

        expect(result[:success]).to be_falsey
        expect(result[:errors]).to be_present
        expect(administrator.reload.email).to eq("old_email@example.com")
      end
    end
  end
end
