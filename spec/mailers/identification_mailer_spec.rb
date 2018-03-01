require "rails_helper"

RSpec.describe IdentificationMailer, type: :mailer do
  before do
    @locale = I18n.locale

    @admin = AdminUser.first ||
      AdminUser.create(email: "admin@example.com", password: "password")
    @user = FactoryGirl.create(:user)
    @identification = @user.identification
  end

  describe "send_identification_is_approved_notification" do
    before do
      @mail = IdentificationMailer.send_identification_is_approved_notification(@identification)
      @subject = I18n.t('identification_mailer.send_identification_is_approved_notification.subject')
    end

    describe "when creating mail and before sending it" do
      specify { expect(ActionMailer::Base.deliveries).to be_empty }

      it "renders the headers" do
        expect(@mail.subject).to eq @subject
        expect(@mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@mail.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@mail.body.to_s).to match(/#{root_url}/)
        expect(@mail.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end

    describe "after sending the mail" do
      before do
        @mail.deliver_now

        @sent_mail = ActionMailer::Base.deliveries.last
      end

      specify { expect(ActionMailer::Base.deliveries.count).to eq 1 }

      it "renders the headers" do
        expect(@sent_mail.subject).to eq @subject
        expect(@sent_mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@sent_mail.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@sent_mail.body.to_s).to match(/#{root_url}/)
        expect(@sent_mail.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end
  end

  describe "send_identification_is_rejected_notification" do
    before do
      @mail = IdentificationMailer.send_identification_is_rejected_notification(@identification)
      @subject = I18n.t('identification_mailer.send_identification_is_rejected_notification.subject')
    end

    describe "when creating mail and before sending it" do
      specify { expect(ActionMailer::Base.deliveries).to be_empty }

      it "renders the headers" do
        expect(@mail.subject).to eq @subject
        expect(@mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@mail.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@mail.body.to_s).to match(/#{root_url}/)
        expect(@mail.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end

    describe "after sending the mail" do
      before do
        @mail.deliver_now

        @sent_mail = ActionMailer::Base.deliveries.last
      end

      specify { expect(ActionMailer::Base.deliveries.count).to eq 1 }

      it "renders the headers" do
        expect(@sent_mail.subject).to eq @subject
        expect(@sent_mail.to.first).to eq @user.email
      end

      it "renders the body" do
        expect(@sent_mail.body.to_s).to match(/#{@user.profile.full_name}/)
        expect(@sent_mail.body.to_s).to match(/#{root_url}/)
        expect(@sent_mail.body.to_s).to match(/#{I18n.t('basic_info.service_name')}/)
      end
    end
  end
end
