require "rails_helper"

describe ReviewMailer do
  before(:all) do
    @host = FactoryGirl.create(:user)
    @guest = FactoryGirl.create(:user)
    @listing = FactoryGirl.create(:listing, user: @host)
    @reservation = FactoryGirl.create(:reservation,
      listing: @listing, host: @host, guest: @guest)
  end

  describe "send_review_opened_notification" do
    before(:all) do
      @review = FactoryGirl.create(:review,
        host: @host, guest: @guest, listing: @listing, reservation: @reservation)
      @review_reply = FactoryGirl.create(:review_reply, review: @review)

      @mail = ReviewMailer.send_review_opened_notification(@reservation)
      @subject = I18n.t('review_mailer.send_review_opened_notification.subject')
    end

    describe "when creating mail and before sending it" do
      specify { expect(ActionMailer::Base.deliveries).to be_empty }

      it "renders the headers" do
        expect(@mail.subject).to eq @subject
        expect(@mail.to.first).to eq @guest.email
      end

      it "renders the body" do
        expect(@mail.body.to_s).to match(/#{@host.profile.full_name}/)
        expect(@mail.body.to_s).to match(/#{@listing.title}/)
        expect(@mail.body.to_s).to match(/#{listing_url(nil, @reservation.listing_id)}/)
      end
    end

    describe "after sending the mail" do
      before(:all) do
        @mail.deliver_now

        @sent_mail = ActionMailer::Base.deliveries.last
      end

      specify { expect(ActionMailer::Base.deliveries.count).to eq 1 }

      it "renders the headers" do
        expect(@sent_mail.subject).to eq @subject
        expect(@sent_mail.to.first).to eq @guest.email
      end

      it "renders the body" do
        expect(@mail.body.to_s).to match(/#{@host.profile.full_name}/)
        expect(@mail.body.to_s).to match(/#{@listing.title}/)
        expect(@mail.body.to_s).to match(/#{listing_url(nil, @reservation.listing_id)}/)
      end
    end
  end
end
