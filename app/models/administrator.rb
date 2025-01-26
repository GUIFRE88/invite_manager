class Administrator < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :administrator_company_invites
  has_many :companies, through: :administrator_company_invites
  has_many :invites, through: :administrator_company_invites
end
