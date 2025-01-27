class DestroyCompany
  def initialize(company)
    @company = company
    @repository = CompanyRepository.new(@company)
  end

  def call
    @repository.destroy!
  end
end
