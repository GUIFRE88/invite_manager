class CreateCompany
  def initialize(company_params)
    @company_params = company_params
  end

  def call
    company = Company.new(@company_params)

    if company.save
      company
    else
      nil
    end
  end
end
