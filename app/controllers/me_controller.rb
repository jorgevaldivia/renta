class MeController < ApplicationController
  before_action :authenticate_user!

  respond_to :json

  def show
    @me = current_user
    respond_with(@me)
  end
end
