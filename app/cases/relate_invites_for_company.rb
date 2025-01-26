class RelateInvitesForCompany
  def initialize(company)
    @company = company
  end

  def call
    related_invites = Invite.joins(:companies)
                            .where(companies: { id: @company.id })

    new_invites = Invite.left_joins(:companies)
                        .where(companies: { id: nil })
    
    (related_invites.to_a + new_invites.to_a).uniq
  end
end
