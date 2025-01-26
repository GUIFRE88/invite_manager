class AdministratorCompanyInvitesController < ApplicationController
  def destroy
    admin_invite = AdministratorCompanyInvite.find_by_id(params[:id])
    admin_id = admin_invite.administrator_id
    admin_invite.destroy
    redirect_to administrator_invites_path(admin_id), notice: "Invite was successfully deleted."
  end
end
