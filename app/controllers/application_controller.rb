class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  # before_action :set_default_locale
  before_action :set_locale
  before_action :reset_session
  before_filter :configure_permitted_parameters, if: :devise_controller?
    
  # Using cancancan
  # watch app/models/ability.rb
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, alert: I18n.t('regulate_user.cancan.failure') }
      format.json { head :no_content  }
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def reset_session
    if params[:controller] != 'profiles' && params[:controller] != 'profile_images'
      session[:listing_id] = nil
    end
  end
  
  def check_identification!
    unless current_user.identification_approved?
      if current_user.identification.nil?
        flash[:warning] = I18n.t("alerts.identification.check.not_yet",
                               model: Identification.model_name.human)
      else
        flash[:warning] = I18n.t("alerts.identification.check.under_review",
                               model: Identification.model_name.human)
      end
      redirect_to profile_identification_url, notice: notice
    end
  end
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update)  << :mode
  end
end
