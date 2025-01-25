class AdministratorsController < ApplicationController
  before_action :authenticate_administrator!

  def index
    @administrators = Administrator.all
  end
end
