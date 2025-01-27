# app/controllers/companies_controller.rb

class CompaniesController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_company, only: %i[show edit update destroy relate_invites associate_invites]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = CreateCompany.new(company_params).call

    respond_to do |format|
      if @company.persisted?
        format.html { redirect_to @company, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @company = UpdateCompany.new(@company, company_params).call

    respond_to do |format|
      if @company.persisted?
        format.html { redirect_to @company, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    DestroyCompany.new(@company).call

    respond_to do |format|
      format.html { redirect_to companies_path, status: :see_other, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def relate_invites
    @invites = RelateInvitesForCompany.new(@company).call
  end

  def associate_invites
    invite_ids = params[:invite_ids] || []
    AssociateInvitesForCompany.new(@company, invite_ids).call
    redirect_to company_path(@company), notice: "Invites successfully associated."
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.require(:company).permit(:name)
  end
end
