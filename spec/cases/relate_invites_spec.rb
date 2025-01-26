RSpec.describe RelateInvites, type: :service do
  describe '#call' do
    let!(:administrator) { create(:administrator) }
    let!(:company1) { create(:company) }
    let!(:company2) { create(:company) }
    let!(:invite1) { create(:invite) }
    let!(:invite2) { create(:invite) }
    let!(:invite3) { create(:invite) }
    
    before do
      create(:company_invite, company: company1, invite: invite1)
      create(:company_invite, company: company2, invite: invite2)
    end

    context 'quando existem convites já associados ao administrador' do
      before do
        create(:administrator_company_invite, administrator: administrator, invite: invite1)
      end

      it 'retorna apenas convites não associados ao administrador' do
        service = RelateInvites.new(administrator)
        result = service.call
        invite_ids = result.map(&:invite_id)

        expect(invite_ids).to include(invite2.id)
      end
    end

    context 'quando não existem convites associados ao administrador' do
      it 'retorna todos os convites de empresas que não foram associados ao administrador' do
        service = RelateInvites.new(administrator)
        result = service.call

        invite_ids = result.map(&:invite_id)

        expect(invite_ids).to include(invite1.id)
      end
    end

    context 'quando não existem convites relacionados à empresa' do
      it 'retorna apenas os convites não associados ao administrador' do
        AdministratorCompanyInvite.destroy_all
        
        service = RelateInvites.new(administrator)
        result = service.call

        invite_ids = result.map(&:invite_id)

        expect(invite_ids).to include(invite1.id)
      end
    end
  end
end
