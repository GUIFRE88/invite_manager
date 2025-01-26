class DeleteInvite
  def initialize(admin_invite_id)
    @admin_invite_id = admin_invite_id
  end

  def call
    admin_invite = AdministratorCompanyInvite.find_by(id: @admin_invite_id)

    if admin_invite
      admin_id = admin_invite.administrator_id
      admin_invite.destroy
      { success: true, admin_id: admin_id }
    else
      { success: false, error: "Invite not found." }
    end
  end
end
