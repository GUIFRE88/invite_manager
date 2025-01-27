require 'rails_helper'

RSpec.describe CompanyRepository, type: :model do
  let!(:company) { create(:company) }
  let(:repository) { CompanyRepository.new(company) }

  describe '#create!' do
    let(:valid_params) { { name: 'New Company' } }
    let(:invalid_params) { { name: '' } }

    context 'when the parameters are valid' do
      it 'creates a new company' do
        repository = CompanyRepository.new
        new_company = repository.create!(valid_params)

        expect(new_company).to be_persisted
        expect(new_company.name).to eq(valid_params[:name])
      end
    end

    context 'when the parameters are invalid' do
      it 'returns nil' do
        repository = CompanyRepository.new
        result = repository.create!(invalid_params)

        expect(result.persisted?).to be_falsey
      end
    end
  end

  describe '#destroy!' do
    it 'destroys the company' do
      expect { repository.destroy! }.to change { Company.count }.by(-1)
    end
  end

  describe '#update!' do
    let(:valid_params) { { name: 'Updated Company Name' } }
    let(:invalid_params) { { name: '' } }

    context 'when the parameters are valid' do
      it 'updates the company' do
        updated_company = repository.update!(valid_params)

        expect(updated_company).to eq(company)
        expect(updated_company.name).to eq(valid_params[:name])
      end
    end

    context 'when the parameters are invalid' do
      it 'returns nil' do
        result = repository.update!(invalid_params)

        expect(result.persisted?).to be_truthy
      end
    end
  end
end
