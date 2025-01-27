require 'rails_helper'

RSpec.describe ListCompanies, type: :service do
  describe '#call' do
    let!(:companies) { create_list(:company, 3) }
    let(:service) { ListCompanies.new }

    it 'returns all companies' do
      result = service.call

      expect(result).to match_array(companies)
    end

    it 'calls the index method of the repository' do
      repository = double('CompanyRepository')
      allow(CompanyRepository).to receive(:new).and_return(repository)
      allow(repository).to receive(:index).and_return(companies)

      service.call

      expect(repository).to have_received(:index)
    end
  end
end
