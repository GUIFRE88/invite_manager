require 'rails_helper'

RSpec.describe DestroyAdministrator, type: :service do
  describe '#call' do
    context 'when the administrator is successfully deleted' do
      let!(:administrator) { create(:administrator) }

      it 'delete the administrator and return success' do
        service = DestroyAdministrator.new(administrator)

        result = service.call

        expect(result[:success]).to be true
        expect(Administrator.exists?(administrator.id)).to be false
      end
    end

    context 'when administrator deletion fails' do
      let!(:administrator) { create(:administrator) }

      before do
        allow(administrator).to receive(:destroy).and_return(false)
        allow(administrator).to receive(:errors).and_return(double(full_messages: ["Destruction failed"]))
      end

      it 'returns error when failed' do
        service = DestroyAdministrator.new(administrator)

        result = service.call

        expect(result[:success]).to be false
        expect(result[:errors]).to eq(administrator.errors)
      end
    end
  end
end
