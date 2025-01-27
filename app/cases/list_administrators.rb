class ListAdministrators
  def initialize()
    @repository = AdministratorRepository.new()
  end

  def call
    @repository.list
  end
end
