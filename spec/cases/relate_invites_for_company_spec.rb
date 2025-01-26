require 'rails_helper'

RSpec.describe RelateInvitesForCompany, type: :service do
  describe '#call' do
    let!(:company) { create(:company) }
    let!(:invite1) { create(:invite) }
    let!(:invite2) { create(:invite) }
    let!(:invite3) { create(:invite) }
    
    before do
      company.invites << invite1
      company.invites << invite2
    end

    context 'quando existem convites relacionados à empresa' do
      it 'retorna os convites relacionados e não relacionados à empresa' do
        service = RelateInvitesForCompany.new(company)
        result = service.call

        expect(result).to contain_exactly(invite1, invite2, invite3)
        expect(result.count).to eq(3)
      end
    end

    context 'quando existem apenas convites não relacionados' do
      it 'retorna apenas os convites não relacionados' do
        company.invites.destroy_all

        service = RelateInvitesForCompany.new(company)
        result = service.call

        expect(result.map(&:id)).to match_array([invite1.id, invite2.id, invite3.id])
      end
    end

    context 'quando há convites relacionados e novos convites não relacionados' do
      it 'retorna todos os convites, garantindo que sejam únicos' do
        service = RelateInvitesForCompany.new(company)
        result = service.call

        expect(result).to contain_exactly(invite1, invite2, invite3)
        expect(result.count).to eq(3)
      end
    end
  end
end
