class AddReviewOpenedMailSentAtToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :review_opened_mail_sent_at, :datetime
  end
end
