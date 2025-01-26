class RelateInvites
  def initialize(administrator)
    @administrator = administrator
  end

  def call
    CompanyInvite
      .includes(:company, :invite)
      .where.not(
        id: AdministratorCompanyInvite
              .where(administrator_id: @administrator.id)
              .select(:invite_id)
      )
  end
end
