class CompanyInvite < ApplicationRecord
  has_many :administrator_company_invites
  has_many :administrators, through: :administrator_company_invites
  belongs_to :company
  belongs_to :invite
end
