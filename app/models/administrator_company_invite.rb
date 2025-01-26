class AdministratorCompanyInvite < ApplicationRecord
  belongs_to :administrator
  belongs_to :company
  belongs_to :invite
end
