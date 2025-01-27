class FilterAdministratorInvites
  def initialize(administrator, params)
    @administrator = administrator
    @params = params
    @repository = AdministratorRepository.new(@administrator)
  end

  def call
    @repository.filter_administrador_invites(@params)
  end
end
