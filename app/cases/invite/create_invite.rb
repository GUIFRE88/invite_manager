class CreateInvite
  def initialize(params)
    @params = params
    @repository = InviteRepository.new()
  end

  def call
    @repository.create(@params)
  end
end
