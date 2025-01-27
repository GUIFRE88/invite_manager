require 'rails_helper'

RSpec.describe CreateCompany, type: :service do
  describe '#call' do
    context 'quando os parâmetros da empresa são válidos' do
      let(:valid_params) { { name: "New Company" } }

      it 'cria a empresa com sucesso' do
        service = CreateCompany.new(valid_params)

        company = service.call

        expect(company).to be_a(Company)
        expect(company.name).to eq("New Company")
        expect(company.persisted?).to be_truthy
      end
    end

    context 'quando os parâmetros da empresa são inválidos' do
      let(:invalid_params) { { name: nil } }

      it 'não cria a empresa' do
        service = CreateCompany.new(invalid_params)

        company = service.call

        expect(company.persisted?).to be_falsey
      end
    end
  end
end
