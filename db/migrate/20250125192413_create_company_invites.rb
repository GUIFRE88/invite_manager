class CreateCompanyInvites < ActiveRecord::Migration[7.1]
  def change
    create_table :company_invites do |t|
      t.references :company, null: false, foreign_key: true
      t.references :invite, null: false, foreign_key: true

      t.timestamps
    end
  end
end
