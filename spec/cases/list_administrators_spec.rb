require 'rails_helper'

RSpec.describe ListAdministrators, type: :service do
  describe '#call' do
    context 'quando há administradores cadastrados' do
      let!(:administrator1) { create(:administrator, email: "admin1@example.com") }
      let!(:administrator2) { create(:administrator, email: "admin2@example.com") }

      it 'retorna todos os administradores' do
        service = ListAdministrators.new

        administrators = service.call

        expect(administrators.count).to eq(2)
        expect(administrators.first.email).to eq("admin1@example.com")
        expect(administrators.second.email).to eq("admin2@example.com")
      end
    end

    context 'quando não há administradores cadastrados' do
      it 'retorna uma lista vazia' do
        service = ListAdministrators.new

        administrators = service.call

        expect(administrators).to be_empty
      end
    end
  end
end
