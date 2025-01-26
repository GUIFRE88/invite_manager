class AssociateInvitesForCompany
  def initialize(company, invite_ids)
    @company = company
    @invite_ids = invite_ids
  end

  def call
    @company.invites.each do |invite|
      unless @invite_ids.include?(invite.id.to_s)
        @company.invites.delete(invite)
      end
    end

    @invite_ids.each do |invite_id|
      invite = Invite.find(invite_id)
      @company.invites << invite unless @company.invites.exists?(invite.id)
    end
  end
end
