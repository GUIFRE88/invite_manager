class AddIndexToAdministratorCompanyInvites < ActiveRecord::Migration[7.1]
  def change
    add_index :administrator_company_invites, 
              [:administrator_id, :company_id, :invite_id], 
              name: 'index_admin_company_invites_on_admin_company_invite'
  end
end
