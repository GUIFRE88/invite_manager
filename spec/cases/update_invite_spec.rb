require 'rails_helper'

RSpec.describe UpdateInvite, type: :service do
  let(:invite) { create(:invite) }
  let(:valid_params) { { name: 'Updated Invite', date_completion: '2025-02-01' } }
  let(:invalid_params) { { name: nil, date_completion: '2025-02-01' } }

  describe '#call' do
    context 'when params are valid' do
      it 'updates the invite successfully' do
        service = UpdateInvite.new(invite, valid_params)

        result = service.call

        expect(result).to be_truthy
        invite.reload
        expect(invite.name).to eq('Updated Invite')
        expect(invite.date_completion.strftime('%Y-%m-%d')).to eq('2025-02-01')
      end
    end

    context 'when params are invalid' do
      it 'does not update the invite' do
        service = UpdateInvite.new(invite, invalid_params)

        result = service.call

        expect(result).to be_falsey
        invite.reload
        expect(invite.name).not_to be_nil
      end
    end
  end
end
