class UpdateCompany
  def initialize(company, company_params)
    @company = company
    @company_params = company_params
  end

  def call
    if @company.update(@company_params)
      @company
    else
      nil
    end
  end
end
