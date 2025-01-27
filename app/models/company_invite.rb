class CompanyInvite < ApplicationRecord
  has_many :administrator_company_invites, dependent: :destroy
  has_many :administrators, through: :administrator_company_invites
  belongs_to :company
  belongs_to :invite
end
