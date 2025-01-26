class FilterInvites
  def initialize(invites_relation, params)
    @invites_relation = invites_relation
    @params = params
  end

  def call
    filter_by_invite_name
    filter_by_company_name
    filter_by_date_range
    @invites_relation
  end

  private

  def filter_by_invite_name
    return unless @params[:invite_name].present?

    @invites_relation = @invites_relation.joins(:invite).where('invites.name LIKE ?', "%#{@params[:invite_name]}%")
  end

  def filter_by_company_name
    return unless @params[:company_name].present?

    @invites_relation = @invites_relation.joins(:company).where('companies.name LIKE ?', "%#{@params[:company_name]}%")
  end

  def filter_by_date_range
    if @params[:start_date].present? && @params[:end_date].present?
      @invites_relation = @invites_relation.joins(:invite).where('invites.date_completion BETWEEN ? AND ?', @params[:start_date], @params[:end_date])
    elsif @params[:start_date].present?
      @invites_relation = @invites_relation.joins(:invite).where('invites.date_completion >= ?', @params[:start_date])
    elsif @params[:end_date].present?
      @invites_relation = @invites_relation.joins(:invite).where('invites.date_completion <= ?', @params[:end_date])
    end
  end
end
