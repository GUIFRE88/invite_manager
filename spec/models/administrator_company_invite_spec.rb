require 'rails_helper'

RSpec.describe AdministratorCompanyInvite, type: :model do
  describe 'associations' do
    it { should belong_to(:administrator) }
    it { should belong_to(:company) }
    it { should belong_to(:invite) }
  end
end
