class CompanyRepository
  def initialize(company = nil)
    @company = company
  end

  def create!(company_params)
    company = Company.new(company_params)
    company.save
    company
  end

  def destroy!()
    @company.destroy!
  end

  def update!(company_params)
    @company.update(company_params)
    @company
  end

end