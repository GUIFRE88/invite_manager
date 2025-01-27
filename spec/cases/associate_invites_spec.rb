require 'rails_helper'

RSpec.describe AssociateInvites, type: :service do
  let!(:administrator) { create(:administrator) }
  let!(:company) { create(:company) }
  let!(:invite1) { create(:invite) }
  let!(:invite2) { create(:invite) }

  describe '#call' do
    context 'when invitation parameters are valid' do
      it 'associates invitations with the administrator and the company' do
        invite_params = {
          invite1.id.to_s => {
            "selected" => "true",
            "company_id" => company.id
          },
          invite2.id.to_s => {
            "selected" => "false",
            "company_id" => company.id
          }
        }

        service = AssociateInvites.new(administrator, invite_params)
        service.call

        expect(AdministratorCompanyInvite.count).to eq(1)
        expect(AdministratorCompanyInvite.first.administrator).to eq(administrator)
        expect(AdministratorCompanyInvite.first.company).to eq(company)
        expect(AdministratorCompanyInvite.first.invite).to eq(invite1)

        expect(AdministratorCompanyInvite.exists?(invite_id: invite2.id)).to be_falsey
      end
    end

    context 'when invitation parameters are empty' do
      it 'does not associate any invitation with the administrator' do
        invite_params = {}

        service = AssociateInvites.new(administrator, invite_params)
        service.call

        expect(AdministratorCompanyInvite.count).to eq(0)
      end
    end

    context 'when the selected parameter is "false"' do
      it 'does not associate the invitation with the administrator' do
        invite_params = {
          invite1.id.to_s => {
            "selected" => "false",
            "company_id" => company.id
          }
        }

        service = AssociateInvites.new(administrator, invite_params)
        service.call

        expect(AdministratorCompanyInvite.count).to eq(0)
      end
    end
  end
end
