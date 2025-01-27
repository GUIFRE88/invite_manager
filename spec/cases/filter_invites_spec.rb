require 'rails_helper'

RSpec.describe FilterInvites, type: :service do
  let!(:administrator) { create(:administrator) }
  let!(:company1) { create(:company, name: "Company A") }
  let!(:company2) { create(:company, name: "Company B") }
  let!(:invite1) { create(:invite, name: "Invite 1", date_completion: "2025-02-01") }
  let!(:invite2) { create(:invite, name: "Invite 2", date_completion: "2025-03-01") }
  
  let!(:administrator_company_invite1) { create(:administrator_company_invite, administrator: administrator, company: company1, invite: invite1) }
  let!(:administrator_company_invite2) { create(:administrator_company_invite, administrator: administrator, company: company2, invite: invite2) }

  describe '#call' do
    context 'when the invitation name filter is applied' do
      it 'returns invitations that match the invitation name' do
        params = { invite_name: "Invite 1" }

        service = FilterInvites.new(AdministratorCompanyInvite.all, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(1)
        expect(filtered_invites.first.invite.name).to eq("Invite 1")
      end
    end

    context 'when company name filter is applied' do
      it 'returns invitations that match the company name' do
        params = { company_name: "Company A" }

        service = FilterInvites.new(AdministratorCompanyInvite.all, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(1)
        expect(filtered_invites.first.company.name).to eq("Company A")
      end
    end

    context 'when start and end date filters are applied' do
      it 'returns invitations within the date range' do
        params = { start_date: "2025-02-01", end_date: "2025-02-28" }

        service = FilterInvites.new(AdministratorCompanyInvite.all, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(1)
        expect(filtered_invites.first.invite.date_completion.to_s).to eq("2025-02-01")
      end
    end

    context 'when only the start date filter is applied' do
      it 'returns invitations with an end date equal to or greater than the start date' do
        params = { start_date: "2025-03-01" }

        service = FilterInvites.new(AdministratorCompanyInvite.all, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(1)
        expect(filtered_invites.first.invite.date_completion.to_s).to eq("2025-03-01")
      end
    end

    context 'when only the end date filter is applied' do
      it 'returns invitations with a completion date equal to or less than the end date' do
        params = { end_date: "2025-02-15" }

        service = FilterInvites.new(AdministratorCompanyInvite.all, params)

        filtered_invites = service.call

        expect(filtered_invites.count).to eq(1)
        expect(filtered_invites.first.invite.date_completion.to_s).to eq("2025-02-01")
      end
    end
  end
end
