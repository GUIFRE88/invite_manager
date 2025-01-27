class DestroyAdministrator
  def initialize(administrator)
    @administrator = administrator
    @repository = AdministratorRepository.new(@administrator)
  end

  def call
    if @repository.destroy!
      return { success: true }
    else
      return { success: false, errors: @administrator.errors }
    end
  end
end
