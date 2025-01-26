require 'rails_helper'

RSpec.describe DestroyAdministrator, type: :service do
  describe '#call' do
    context 'quando o administrador é excluído com sucesso' do
      let!(:administrator) { create(:administrator) }

      it 'deleta o administrador e retorna sucesso' do
        service = DestroyAdministrator.new(administrator)

        result = service.call

        expect(result[:success]).to be true
        expect(Administrator.exists?(administrator.id)).to be false
      end
    end

    context 'quando a exclusão do administrador falha' do
      let!(:administrator) { create(:administrator) }

      before do
        allow(administrator).to receive(:destroy).and_return(false)
        allow(administrator).to receive(:errors).and_return(double(full_messages: ["Destruction failed"]))
      end

      it 'retorna erro quando falha' do
        service = DestroyAdministrator.new(administrator)

        result = service.call

        expect(result[:success]).to be false
        expect(result[:errors]).to eq(administrator.errors)
      end
    end
  end
end
