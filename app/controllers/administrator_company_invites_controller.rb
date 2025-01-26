class AdministratorCompanyInvitesController < ApplicationController
  def destroy
    result = DeleteInvite.new(params[:id]).call

    if result[:success]
      redirect_to administrator_invites_path(result[:admin_id]), notice: "Invite was successfully deleted."
    else
      redirect_to administrator_invites_path(params[:administrator_id]), alert: result[:error]
    end
  end
end
