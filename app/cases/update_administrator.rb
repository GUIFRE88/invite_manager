class UpdateAdministrator
  def initialize(administrator, params)
    @administrator = administrator
    @params = params
    @repository = AdministratorRepository.new(@administrator)
  end

  def call
    @repository.update!(@params)
  end
end
