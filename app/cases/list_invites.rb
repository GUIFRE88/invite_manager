class ListInvites
  def initialize(params = {})
    @params = params
    @repository = InviteRepository.new()
  end

  def call
    @repository.list_invites
  end
end
