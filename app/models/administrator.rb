class Administrator < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :administrator_company_invites, dependent: :destroy
  has_many :companies, through: :administrator_company_invites
  has_many :invites, through: :administrator_company_invites

  validates :email, :password, presence: true
end
