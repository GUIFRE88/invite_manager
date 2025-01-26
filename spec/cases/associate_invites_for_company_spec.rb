require 'rails_helper'

RSpec.describe AssociateInvitesForCompany, type: :service do
  let!(:company) { create(:company) }
  let!(:invite1) { create(:invite) }
  let!(:invite2) { create(:invite) }
  let!(:invite3) { create(:invite) }

  before do
    company.invites << invite1
    company.invites << invite2
  end

  describe '#call' do
    context 'quando um convite é removido' do
      it 'remove o convite da empresa' do
        invite_ids = [invite1.id.to_s]

        service = AssociateInvitesForCompany.new(company, invite_ids)
        service.call

        expect(company.invites).to include(invite1)
        expect(company.invites).not_to include(invite2)
      end
    end

    context 'quando novos convites são adicionados' do
      it 'adiciona os convites à empresa' do
        invite_ids = [invite1.id.to_s, invite2.id.to_s, invite3.id.to_s]  # Adicionando o invite3

        service = AssociateInvitesForCompany.new(company, invite_ids)
        service.call

        expect(company.invites).to include(invite1, invite2, invite3)
      end
    end

    context 'quando o mesmo convite já está associado' do
      it 'não adiciona convites duplicados' do
        invite_ids = [invite1.id.to_s, invite2.id.to_s]

        service = AssociateInvitesForCompany.new(company, invite_ids)
        service.call

        expect(company.invites.count).to eq(2)
      end
    end
  end
end
