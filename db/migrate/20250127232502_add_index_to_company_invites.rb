class AddIndexToCompanyInvites < ActiveRecord::Migration[7.1]
  def change
    add_index :company_invites, 
              [:company_id, :invite_id], 
              name: 'index_company_invites_on_company_invite'
  end
end
