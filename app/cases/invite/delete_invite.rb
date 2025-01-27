class DeleteInvite
  def initialize(admin_invite_id)
    @admin_invite_id = admin_invite_id
    @repository = InviteRepository.new()
  end

  def call
    @repository.delete(@admin_invite_id)
  end
end
