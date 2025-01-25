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
    puts 'Caiu na rotaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    @administrator.destroy
    redirect_to new_administrator_session_path, notice: 'Administrador excluído com sucesso.'
  end

  private

  def set_administrator
    @administrator = Administrator.find(params[:id])
  end

  def administrator_params
    params.require(:administrator).permit(:first_name, :last_name, :email)
  end
end
