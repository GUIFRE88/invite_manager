class UpdateAdministrator
  def initialize(administrator, params)
    @administrator = administrator
    @params = params
  end

  def call
    if @administrator.update(@params)
      return { success: true, administrator: @administrator }
    else
      return { success: false, errors: @administrator.errors }
    end
  end
end
