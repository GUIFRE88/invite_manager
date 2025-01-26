class DestroyCompany
  def initialize(company)
    @company = company
  end

  def call
    @company.destroy!
  end
end
