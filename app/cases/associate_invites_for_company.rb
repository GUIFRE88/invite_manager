class AssociateInvitesForCompany
  def initialize(company, invite_ids)
    @company = company
    @invite_ids = invite_ids
    @repository = InviteRepository.new()
  end

  def call
    @company = @repository.associate_invites_for_company(@company, @invite_ids)
  end
end
