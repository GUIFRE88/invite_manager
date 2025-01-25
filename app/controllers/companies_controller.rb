class CompaniesController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_company, only: %i[ show edit update destroy ]

  # GET /companies or /companies.json
  def index
    @companies = Company.all
  end

  # GET /companies/1 or /companies/1.json
  def show
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
  end

  # POST /companies or /companies.json
  def create
    @company = Company.new(company_params)

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: "Company was successfully created." }
        format.json { render :show, status: :created, location: @company }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies/1 or /companies/1.json
  def update
    respond_to do |format|
      if @company.update(company_params)
        format.html { redirect_to @company, notice: "Company was successfully updated." }
        format.json { render :show, status: :ok, location: @company }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1 or /companies/1.json
  def destroy
    @company.destroy!

    respond_to do |format|
      format.html { redirect_to companies_path, status: :see_other, notice: "Company was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def relate_invites
    @company = Company.find(params[:id])
    
    related_invites = Invite.joins(:companies)
                            .where(companies: { id: @company.id })
    
    new_invites = Invite.left_joins(:companies)
                        .where(companies: { id: nil })
    
    @invites = (related_invites.to_a + new_invites.to_a).uniq
  end
  
  def associate_invites
    @company = Company.find(params[:id])
    invite_ids = params[:invite_ids] || []

    # Remover os convites que foram desmarcados
    @company.invites.each do |invite|
      unless invite_ids.include?(invite.id.to_s)
        @company.invites.delete(invite)
      end
    end

    # Adicionar os convites selecionados que ainda não estão associados
    invite_ids.each do |invite_id|
      invite = Invite.find(invite_id)
      @company.invites << invite unless @company.invites.exists?(invite.id)
    end

    redirect_to company_path(@company), notice: "Invites successfully associated."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_company
      @company = Company.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name)
    end
end
