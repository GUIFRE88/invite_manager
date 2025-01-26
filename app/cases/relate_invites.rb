class RelateInvites
  def initialize(administrator)
    @administrator = administrator
    @repository = InviteRepository.new()
  end

  def call
    @repository.relate_invites(@administrator)
  end
end
