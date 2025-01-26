class FilterAdministratorInvites
  def initialize(administrator, params)
    @administrator = administrator
    @params = params
  end

  def call
    invites = AdministratorCompanyInvite
                .includes(:invite, :company)
                .where(administrator_id: @administrator.id)

    FilterInvites.new(invites, @params).call
  end
end
