class AssociateInvites
  def initialize(administrator, invite_params)
    @administrator = administrator
    @invite_params = invite_params
  end

  def call
    return unless @invite_params.present?

    @invite_params.each do |invite_id, data|
      if data["selected"] == "true"
        company_id = data["company_id"]
        
        AdministratorCompanyInvite.create(
          administrator: @administrator,
          invite_id: invite_id,
          company_id: company_id
        )
      end
    end
  end
end
