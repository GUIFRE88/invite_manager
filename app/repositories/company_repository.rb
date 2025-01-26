class CompanyRepository
  def initialize(company = nil)
    @company = company
  end

  def create!(company_params)
    company = Company.new(company_params)

    if company.save
      company
    else
      nil
    end

  end

  def destroy!()
    @company.destroy!
  end

  def update!(company_params)
    if @company.update(company_params)
      @company
    else
      nil
    end
  end

end