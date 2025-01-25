class CompanyInvite < ApplicationRecord
  belongs_to :company
  belongs_to :invite
end
