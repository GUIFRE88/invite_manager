require 'rails_helper'

RSpec.describe ListInvites, type: :service do
  describe '#call' do
    context 'quando há convites cadastrados' do
      let!(:invite1) { create(:invite, name: "Invite 1", date_completion: "2025-02-01") }
      let!(:invite2) { create(:invite, name: "Invite 2", date_completion: "2025-02-02") }

      it 'retorna todos os convites' do
        service = ListInvites.new

        invites = service.call

        expect(invites.count).to eq(2)
        expect(invites.first.name).to eq("Invite 1")
        expect(invites.second.name).to eq("Invite 2")
      end
    end

    context 'quando não há convites cadastrados' do
      it 'retorna uma lista vazia' do
        service = ListInvites.new

        invites = service.call

        expect(invites).to be_empty
      end
    end
  end
end
