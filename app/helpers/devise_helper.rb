module DeviseHelper
  def devise_error_messages!
    device_notification(resource.errors.empty?)
    flash.now[:messages] = resource.errors.full_messages
  end
  def devise_edit_is_email?(mode)
    mode.present? && mode == "email"
  end
  def devise_edit_is_password?(mode)
    mode.present? && mode == "password"
  end

  private
  def device_notification(error_flag)
    if !error_flag
      flash[:alert] = I18n.t('errors.messages.not_saved.other', count: resource.errors.size,
                             resource: I18n.t("activerecord.attributes.user.#{resource.mode}"))
    else
      flash[:success] = I18n.t('registrations.user.updated')
    end
  end
end
