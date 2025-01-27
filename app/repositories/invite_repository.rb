class InviteRepository
  def initialize(invite = nil)
    @invite = invite
  end

  def update(params)
    @invite.update(params)
  end

  def relate_invites(administrator)
    CompanyInvite
    .includes(:company, :invite)
    .where.not(
      id: AdministratorCompanyInvite
            .where(administrator_id: administrator.id)
            .select(:invite_id)
    )
  end

  def relate_invites_for_company(company)
    related_invites = Invite.joins(:companies)
    .where(companies: { id: company.id })

    new_invites = Invite.left_joins(:companies)
    .where(companies: { id: nil })

    (related_invites.to_a + new_invites.to_a).uniq
  end

  def list_invites
    Invite.all
  end

  def destroy!
    @invite.destroy!
  end

  def create(params)
    invite = Invite.new(params)
    invite.save
    invite
  end

  def delete(admin_invite_id)
    admin_invite = AdministratorCompanyInvite.find_by(id: admin_invite_id)

    if admin_invite
      admin_id = admin_invite.administrator_id
      admin_invite.destroy
      { success: true, admin_id: admin_id }
    else
      { success: false, error: "Invite not found." }
    end
  end

  def associate_invites(invite_params,administrator)
    invite_params.each do |invite_id, data|
      if data["selected"] == "true"
        company_id = data["company_id"]
        
        AdministratorCompanyInvite.create(
          administrator: administrator,
          invite_id: invite_id,
          company_id: company_id
        )
      end
    end
  end

  def associate_invites_for_company(company, invite_ids)
    company.invites.each do |invite|
      unless invite_ids.include?(invite.id.to_s)
        company.invites.delete(invite)
      end
    end

    invite_ids.each do |invite_id|
      invite = Invite.find_by_id(invite_id)

      return company unless invite.present?

      company.invites << invite unless company.invites.exists?(invite.id)
    end

    company
  end
end
