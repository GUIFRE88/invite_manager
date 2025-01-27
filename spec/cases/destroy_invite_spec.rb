require 'rails_helper'

RSpec.describe DestroyInvite, type: :service do
  describe '#call' do
    context 'when the invite is successfully destroyed' do
      let!(:invite) { create(:invite) }

      it 'returns success and the invite is destroyed' do
        service = DestroyInvite.new(invite)

        expect {
          service.call
        }.to change { Invite.count }.by(-1)

        expect(Invite.exists?(invite.id)).to be false
      end
    end

    context 'when invite destruction fails' do
      let!(:invite) { create(:invite) }

      before do
        allow(invite).to receive(:destroy!).and_raise(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end

      it 'returns error when failed' do
        service = DestroyInvite.new(invite)

        expect {
          service.call
        }.to raise_error(ActiveRecord::RecordNotDestroyed, "Destruction failed")
      end
    end
  end
end
