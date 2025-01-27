require 'rails_helper'

RSpec.describe DestroyCompany, type: :service do
  describe '#call' do
    context 'when the company is successfully destroyed' do
      let!(:company) { create(:company) }

      it 'returns success and the company is destroyed' do
        service = DestroyCompany.new(company)

        expect {
          service.call
        }.to change { Company.count }.by(-1)

        expect(Company.exists?(company.id)).to be false
      end
    end

    context 'when company destruction fails' do
      let!(:company) { create(:company) }

      before do
        allow(company).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end

      it 'returns error when failed' do
        service = DestroyCompany.new(company)

        expect {
          service.call
        }.to raise_error(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end
    end
  end
end
