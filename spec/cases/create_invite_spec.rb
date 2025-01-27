require 'rails_helper'

RSpec.describe CreateInvite, type: :service do
  describe '#call' do
    context 'when the parameters are valid' do
      let(:valid_params) { { name: "Special Invitation", date_completion: 1.year.from_now } }

      it 'successfully create a new invitation' do
        service = CreateInvite.new(valid_params)

        invite = service.call

        expect(invite).to be_a(Invite)
        expect(invite.name).to eq("Special Invitation")
        expect(invite).to be_persisted
      end
    end

    context 'when parameters are invalid' do
      let(:invalid_params) { { name: nil, date_completion: nil } }

      it 'does not create an invitation' do
        service = CreateInvite.new(invalid_params)

        invite = service.call

        expect(invite).to be_a(Invite)
        expect(invite.name).to be_nil
        expect(invite.date_completion).to be_nil
        expect(invite).not_to be_persisted
      end
    end
  end
end
