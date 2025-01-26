class UpdateInvite
  def initialize(invite, params)
    @invite = invite
    @params = params
  end

  def call
    @invite.update(@params)
  end
end
