require 'rails_helper'

RSpec.describe DestroyInvite, type: :service do
  describe '#call' do
    context 'quando o invite é destruído com sucesso' do
      let!(:invite) { create(:invite) }

      it 'retorna sucesso e o invite é destruído' do
        service = DestroyInvite.new(invite)

        expect {
          service.call
        }.to change { Invite.count }.by(-1)

        expect(Invite.exists?(invite.id)).to be false
      end
    end

    context 'quando a destruição do invite falha' do
      let!(:invite) { create(:invite) }

      before do
        allow(invite).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end

      it 'retorna erro quando falha' do
        service = DestroyInvite.new(invite)

        expect {
          service.call
        }.to raise_error(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end
    end
  end
end
