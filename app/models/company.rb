class Company < ApplicationRecord
  has_many :company_invites
  has_many :invites, through: :company_invites
end
