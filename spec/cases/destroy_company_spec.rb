require 'rails_helper'

RSpec.describe DestroyCompany, type: :service do
  describe '#call' do
    context 'quando a empresa é destruída com sucesso' do
      let!(:company) { create(:company) }

      it 'retorna sucesso e a empresa é destruída' do
        service = DestroyCompany.new(company)

        expect {
          service.call
        }.to change { Company.count }.by(-1)

        expect(Company.exists?(company.id)).to be false
      end
    end

    context 'quando a destruição da empresa falha' do
      let!(:company) { create(:company) }

      before do
        allow(company).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end

      it 'retorna erro quando falha' do
        service = DestroyCompany.new(company)

        expect {
          service.call
        }.to raise_error(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end
    end
  end
end
