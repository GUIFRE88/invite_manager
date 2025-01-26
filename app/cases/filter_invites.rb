class FilterInvites
  def initialize(administrator_invites, filters)
    @administrator_invites = administrator_invites
    @filters = filters
  end

  def call
    if @filters[:invite_name].present?
      @administrator_invites = @administrator_invites.joins(:invite)
                                                   .where("invites.name LIKE ?", "%#{@filters[:invite_name]}%")
    end
  
    if @filters[:company_name].present?
      @administrator_invites = @administrator_invites.joins(:company)
                                                   .where("companies.name LIKE ?", "%#{@filters[:company_name]}%")
    end
  
    if @filters[:start_date].present? && @filters[:end_date].present?
      @administrator_invites = @administrator_invites.where("invites.date_completion BETWEEN ? AND ?", @filters[:start_date], @filters[:end_date])
    elsif @filters[:start_date].present?
      @administrator_invites = @administrator_invites.where("invites.date_completion >= ?", @filters[:start_date])
    elsif @filters[:end_date].present?
      @administrator_invites = @administrator_invites.where("invites.date_completion <= ?", @filters[:end_date])
    end

    @administrator_invites
  end
end
