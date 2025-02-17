class AdministratorRepository
  def initialize(administrator = nil)
    @administrator = administrator
  end

  def destroy!
    @administrator.destroy
  end

  def index
    Administrator.all
  end

  def update!(params)
    @administrator.email = params[:email]
    if @administrator.save(validate: false)
      return { success: true, administrator: @administrator }
    end
  end

  def filter_administrador_invites(params)
    invites = AdministratorCompanyInvite
      .includes(:invite, :company)
      .where(administrator_id: @administrator.id)

    FilterInvites.new(invites, params).call
  end

end