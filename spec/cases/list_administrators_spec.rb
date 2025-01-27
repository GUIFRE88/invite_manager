require 'rails_helper'

RSpec.describe ListAdministrators, type: :service do
  describe '#call' do
    context 'when there are registered administrators' do
      let!(:administrator1) { create(:administrator, email: "admin1@example.com") }
      let!(:administrator2) { create(:administrator, email: "admin2@example.com") }

      it 'returns all administrators' do
        service = ListAdministrators.new

        administrators = service.call

        expect(administrators.count).to eq(2)
        expect(administrators.first.email).to eq("admin1@example.com")
        expect(administrators.second.email).to eq("admin2@example.com")
      end
    end

    context 'returns all administrators' do
      it 'returns an empty list' do
        service = ListAdministrators.new

        administrators = service.call

        expect(administrators).to be_empty
      end
    end
  end
end
