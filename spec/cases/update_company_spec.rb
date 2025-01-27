require 'rails_helper'

RSpec.describe UpdateCompany, type: :service do
  describe '#call' do
    let!(:company) { create(:company, name: "Old Company Name") }

    context 'quando a atualização é bem-sucedida' do
      let(:new_params) { { name: "New Company Name" } }

      it 'atualiza a empresa com os novos parâmetros' do
        service = UpdateCompany.new(company, new_params)

        updated_company = service.call

        expect(updated_company).to eq(company)
        expect(updated_company.name).to eq("New Company Name")
      end
    end

    context 'quando a atualização falha' do
      let(:invalid_params) { { name: nil } }

      it 'não atualiza a empresa e retorna nil' do
        service = UpdateCompany.new(company, invalid_params)

        result = service.call

        expect(result.persisted?).to be_truthy
      end
    end
  end
end
