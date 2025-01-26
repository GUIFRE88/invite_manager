class DestroyInvite
  def initialize(invite)
    @invite = invite
  end

  def call
    @invite.destroy!
  end
end
