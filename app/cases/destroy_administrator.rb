class DestroyAdministrator
  def initialize(administrator)
    @administrator = administrator
  end

  def call
    if @administrator.destroy
      return { success: true }
    else
      return { success: false, errors: @administrator.errors }
    end
  end
end
