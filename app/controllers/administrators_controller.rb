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
  
    # Redireciona para a página do administrador com uma mensagem de sucesso
    redirect_to administrators_path, notice: "Invitations associated successfully."
  end
  

  private

  def set_administrator
    @administrator = Administrator.find(params[:id])
  end

  def administrator_params
    params.require(:administrator).permit(:first_name, :last_name, :email)
  end
end
