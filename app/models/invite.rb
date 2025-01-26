class Invite < ApplicationRecord
  has_many :company_invites
  has_many :companies, through: :company_invites
  has_many :administrator_company_invites
  has_many :administrators, through: :administrator_company_invites
  has_many :companies, through: :company_invites
end
