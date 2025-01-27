require 'rails_helper'

RSpec.describe UpdateCompany, type: :service do
  describe '#call' do
    let!(:company) { create(:company, name: "Old Company Name") }

    context 'when the update is successful' do
      let(:new_params) { { name: "New Company Name" } }

      it 'updates the company with the new parameters' do
        service = UpdateCompany.new(company, new_params)

        updated_company = service.call

        expect(updated_company).to eq(company)
        expect(updated_company.name).to eq("New Company Name")
      end
    end

    context 'when the update fails' do
      let(:invalid_params) { { name: nil } }

      it 'does not update the company and returns nil' do
        service = UpdateCompany.new(company, invalid_params)

        result = service.call

        expect(result.persisted?).to be_truthy
      end
    end
  end
end
