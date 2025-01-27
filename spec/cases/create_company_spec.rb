require 'rails_helper'

RSpec.describe CreateCompany, type: :service do
  describe '#call' do
    context 'when the company parameters are valid' do
      let(:valid_params) { { name: "New Company" } }

      it 'successfully creates the company' do
        service = CreateCompany.new(valid_params)

        company = service.call

        expect(company).to be_a(Company)
        expect(company.name).to eq("New Company")
        expect(company.persisted?).to be_truthy
      end
    end

    context 'when company parameters are invalid' do
      let(:invalid_params) { { name: nil } }

      it 'does not create the company' do
        service = CreateCompany.new(invalid_params)

        company = service.call

        expect(company.persisted?).to be_falsey
      end
    end
  end
end
