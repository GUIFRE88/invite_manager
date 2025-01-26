class CreateInvite
  def initialize(params)
    @params = params
  end

  def call
    Invite.new(@params)
  end
end
