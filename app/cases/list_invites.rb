class ListInvites
  def initialize(params = {})
    @params = params
  end

  def call
    Invite.all
  end
end
