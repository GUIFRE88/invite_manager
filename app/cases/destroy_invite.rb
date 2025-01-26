class DestroyInvite
  def initialize(invite)
    @invite = invite
    @repository = InviteRepository.new(@invite)
  end

  def call
    @repository.destroy!
  end
end
