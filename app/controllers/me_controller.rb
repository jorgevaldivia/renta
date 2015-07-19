class MeController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show
    @me = current_user
    respond_with(@me)
  end

  def update
    current_user.update(me_params)
    respond_with(@current_user, location: nil)
  end

  private

  def me_params
    params.require(:me).permit(:first_name, :last_name, :email)
  end
end
