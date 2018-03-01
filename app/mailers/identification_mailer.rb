class IdentificationMailer < ApplicationMailer
  def send_identification_is_approved_notification(identification)
    @locale = I18n.locale

    @identification = identification
    @to_user = @identification.user

    mail(
      to: @to_user.email,
      subject: I18n.t('identification_mailer.send_identification_is_approved_notification.subject')
    ) do |format|
      format.text
    end
  end

  def send_identification_is_rejected_notification(identification)
    @locale = I18n.locale

    @identification = identification
    @to_user = @identification.user

    mail(
      to: @to_user.email,
      subject: I18n.t('identification_mailer.send_identification_is_rejected_notification.subject')
    ) do |format|
      format.text
    end
  end
end
