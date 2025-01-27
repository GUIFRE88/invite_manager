class AdministratorsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_administrator, only: [:edit, :update, :destroy, :relate_invites, :associate_invites]
  before_action :set_administrator_for_administrator_id, only: [:invites]

  def index
    @administrators = ListAdministrators.new.call
  end

  def edit
  end

  def update
    result = UpdateAdministrator.new(@administrator, administrator_params).call

    if result[:success]
      redirect_to administrators_path, notice: 'Administrator updated successfully.'
    else
      @administrator = result[:administrator]
      render :edit
    end
  end

  def destroy
    result = DestroyAdministrator.new(@administrator).call

    if result[:success]
      redirect_to new_administrator_session_path, notice: 'Administrator successfully deleted.'
    else
      redirect_to administrators_path, alert: 'Error deleting administrator.'
    end
  end

  def relate_invites
    @company_invites = RelateInvites.new(@administrator).call
  end

  def associate_invites
    invite_params = params[:invites]
    AssociateInvites.new(@administrator, invite_params).call
    redirect_to administrators_path, notice: "Invitations associated successfully."
  end

  def invites
    @administrator_invites = FilterAdministratorInvites.new(@administrator, params).call
    @administrator_invites = FilterInvites.new(@administrator_invites, params).call
  end

  private

  def set_administrator_for_administrator_id
    @administrator = Administrator.find_by_id(params[:administrator_id])
  end

  def set_administrator
    @administrator = Administrator.find_by_id(params[:id])
  end

  def administrator_params
    params.require(:administrator).permit(:name, :email, :role, :password, :password_confirmation)
  end
  
end
