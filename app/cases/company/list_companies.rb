class ListCompanies
  def initialize()
    @repository = CompanyRepository.new()
  end

  def call
    @repository.index
  end
end
