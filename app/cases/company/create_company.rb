class CreateCompany
  def initialize(company_params)
    @company_params = company_params
    @repository = CompanyRepository.new
  end

  def call
    @repository.create!(@company_params)
  end
end
