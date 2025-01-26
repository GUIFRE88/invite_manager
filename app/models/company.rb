class Company < ApplicationRecord
  has_many :company_invites
  has_many :invites, through: :company_invites
  has_many :administrator_company_invites
  has_many :administrators, through: :administrator_company_invites
  has_many :invites, through: :company_invites 

  validates :name, presence: true
end
