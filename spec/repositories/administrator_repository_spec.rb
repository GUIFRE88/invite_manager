require 'rails_helper'

RSpec.describe AdministratorRepository, type: :model do
  let!(:administrator) { create(:administrator, email: 'admin@example.com') }
  let(:repository) { AdministratorRepository.new(administrator) }

  describe '#destroy!' do
    it 'destroys the administrator' do
      expect { repository.destroy! }.to change { Administrator.count }.by(-1)
    end
  end

  describe '#list' do
    let!(:other_administrator) { create(:administrator, email: 'other_admin@example.com') }

    it 'returns all administrators' do
      repository = AdministratorRepository.new
      administrators = repository.index

      expect(administrators).to include(administrator, other_administrator)
      expect(administrators.count).to eq(2)
    end
  end

  describe '#update!' do
    let(:valid_params) { { email: 'updated_admin@example.com' } }
    let(:invalid_params) { { email: '' } }

    context 'when the parameters are valid' do
      it 'updates the administrator and returns success' do
        result = repository.update!(valid_params)

        expect(result[:success]).to be(true)
        expect(result[:administrator].email).to eq(valid_params[:email])
      end
    end

    context 'when the parameters are invalid' do
      it 'does not update the administrator and returns errors' do
        result = repository.update!(invalid_params)

        expect(result[:success]).to be(true)
      end
    end
  end
end
