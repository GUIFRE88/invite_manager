class UpdateCompany
  def initialize(company, company_params)
    @company = company
    @company_params = company_params
    @repository = CompanyRepository.new(@company)
  end

  def call
    @repository.update!(@company_params)
  end
end
