class AdministratorsController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_administrator, only: [:edit, :update, :destroy]

  def index
    @administrators = Administrator.all
  end

  def edit
  end

  def update
    if @administrator.update(administrator_params)
      redirect_to administrators_path, notice: 'Administrador atualizado com sucesso.'
    else
      render :edit
    end
  end

  def destroy
    @administrator.destroy
    redirect_to new_administrator_session_path, notice: 'Administrador excluído com sucesso.'
  end

  def relate_invites
    @administrator = Administrator.find(params[:id])

    @company_invites = CompanyInvite
    .includes(:company, :invite)
    .where.not(
      id: AdministratorCompanyInvite
            .where(administrator_id: @administrator.id)
            .select(:invite_id)
    )
  end


  def associate_invites
    @administrator = Administrator.find(params[:id])
    invite_params = params[:invites]
  
    if invite_params.present?
      invite_params.each do |invite_id, data|
        if data["selected"] == "true"
          company_id = data["company_id"]
          
          # Cria a associação no banco
          AdministratorCompanyInvite.create(
            administrator: @administrator,
            invite_id: invite_id,
            company_id: company_id
          )
        end
      end
    end
    redirect_to administrators_path, notice: "Invitations associated successfully."
  end

  def invites
    @administrator = Administrator.find_by_id(params[:administrator_id])

    @administrator_invites = AdministratorCompanyInvite
                                 .includes(:invite, :company)
                                 .where(administrator_id: @administrator.id)
  
    if params[:invite_name].present?
      @administrator_invites = @administrator_invites.joins(:invite)
                                                  .where("invites.name LIKE ?", "%#{params[:invite_name]}%")
    end
  
     if params[:company_name].present?
      @administrator_invites = @administrator_invites.joins(:company)
                                                  .where("companies.name LIKE ?", "%#{params[:company_name]}%")
    end

    if params[:start_date].present? && params[:end_date].present?
      @administrator_invites = @administrator_invites.where("invites.date_completion BETWEEN ? AND ?", params[:start_date], params[:end_date])
    elsif params[:start_date].present?
      @administrator_invites = @administrator_invites.where("invites.date_completion >= ?", params[:start_date])
    elsif params[:end_date].present?
      @administrator_invites = @administrator_invites.where("invites.date_completion <= ?", params[:end_date])
    end
  end
  

  private

  def set_administrator
    @administrator = Administrator.find(params[:id])
  end

  def administrator_params
    params.require(:administrator).permit(:email, :password, :password_confirmation)
  end

end
