class CreateAdministratorCompanyInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :administrator_company_invites do |t|
      t.references :administrator, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true
      t.references :invite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
