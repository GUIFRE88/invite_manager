class InvitesController < ApplicationController
  before_action :authenticate_administrator!
  before_action :set_invite, only: %i[show edit update destroy]

  def index
    @invites = ListInvites.new.call
  end

  def show
  end

  def new
    @invite = Invite.new
  end

  def edit
  end

  def create
    @invite = CreateInvite.new(invite_params).call

    respond_to do |format|
      if @invite.persisted?
        format.html { redirect_to @invite, notice: "Invite was successfully created." }
        format.json { render :show, status: :created, location: @invite }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if UpdateInvite.new(@invite, invite_params).call
      redirect_to @invite, notice: "Invite was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    DestroyInvite.new(@invite).call

    respond_to do |format|
      format.html { redirect_to invites_path, status: :see_other, notice: "Invite was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_invite
      @invite = Invite.find(params[:id])
    end

    def invite_params
      params.require(:invite).permit(:name, :date_completion)
    end
end
