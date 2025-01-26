require 'rails_helper'

RSpec.describe FilterAdministratorInvites, type: :service do
  let!(:administrator) { create(:administrator) }
  let!(:company) { create(:company) }
  let!(:invite1) { create(:invite, name: "Invite 1", date_completion: "2025-02-01") }
  let!(:invite2) { create(:invite, name: "Invite 2", date_completion: "2025-03-01") }
  
  let!(:administrator_company_invite1) { create(:administrator_company_invite, administrator: administrator, company: company, invite: invite1) }
  let!(:administrator_company_invite2) { create(:administrator_company_invite, administrator: administrator, company: company, invite: invite2) }

  describe '#call' do
    context 'quando um filtro é aplicado corretamente' do
      it 'retorna os convites filtrados para o administrador' do
        params = { name: "Invite 1" }

        service = FilterAdministratorInvites.new(administrator, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(2)
      end

      it 'retorna os convites filtrados corretamente com base na data de conclusão' do
        params = { date_completion: "2025-03-01" }

        service = FilterAdministratorInvites.new(administrator, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(2)
      end
    end

    context 'quando não há filtros aplicados' do
      it 'retorna todos os convites do administrador' do
        service = FilterAdministratorInvites.new(administrator, {})

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(2)
      end
    end
  end
end
