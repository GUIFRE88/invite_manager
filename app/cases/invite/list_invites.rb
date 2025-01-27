class ListInvites
  def initialize(params = {})
    @params = params
    @repository = InviteRepository.new()
  end

  def call
    @repository.index
  end
end
