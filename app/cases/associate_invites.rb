class AssociateInvites
  def initialize(administrator, invite_params)
    @administrator = administrator
    @invite_params = invite_params
    @repository = InviteRepository.new()
  end

  def call
    return unless @invite_params.present?

    @repository.associate_invites(@invite_params,@administrator)
  end
end
