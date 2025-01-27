class ListAdministrators
  def initialize()
    @repository = AdministratorRepository.new()
  end

  def call
    @repository.index
  end
end
