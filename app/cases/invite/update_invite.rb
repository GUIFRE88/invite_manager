class UpdateInvite
  def initialize(invite, params)
    @invite = invite
    @params = params
    @repository = InviteRepository.new(@invite)
  end

  def call
    @invite = @repository.update(@params)
  end
end
