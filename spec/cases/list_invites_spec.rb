require 'rails_helper'

RSpec.describe ListInvites, type: :service do
  describe '#call' do
    context 'when there are registered invitations' do
      let!(:invite1) { create(:invite, name: "Invite 1", date_completion: "2025-02-01") }
      let!(:invite2) { create(:invite, name: "Invite 2", date_completion: "2025-02-02") }

      it 'returns all invitations' do
        service = ListInvites.new

        invites = service.call

        expect(invites.count).to eq(2)
        expect(invites.first.name).to eq("Invite 1")
        expect(invites.second.name).to eq("Invite 2")
      end
    end

    context 'when there are no registered invitations' do
      it 'returns an empty list' do
        service = ListInvites.new

        invites = service.call

        expect(invites).to be_empty
      end
    end
  end
end
