class RelateInvitesForCompany
  def initialize(company)
    @company = company
    @repository = InviteRepository.new()
  end

  def call
    @repository.relate_invites_for_company(@company)
  end
end
