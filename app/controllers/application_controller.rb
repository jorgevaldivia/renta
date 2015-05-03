class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :layout_by_resource

  # Acts as tenant
  set_current_tenant_through_filter
  before_filter :set_tenant_from_user

  protected

  def layout_by_resource
    if devise_controller?
      "sessions"
    else
      "miveus"
    end
  end

  # For now, I'm just gonna set the tenant to always be the current user's only
  # account. 
  def set_tenant_from_user
    return unless current_user.present?

    set_current_tenant(current_user.accounts.first)
  end
end
