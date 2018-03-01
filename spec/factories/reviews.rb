FactoryGirl.define do
  factory :review do
    transient do
      host { FactoryGirl.create(:user) }
      guest { FactoryGirl.create(:user) }
    end

    association :listing, factory: :listing
    association :reservation, factory: :reservation
    #association :host, factory: :host
    #association :guest, factory: :guest
    host_id  { host.id }
    guest_id { guest.id }
    msg "レビューのサンプルです。"
    total { rand(1..5) }

    after(:create) do |review|
      review.reservation.reviewed_at = Time.zone.now
      review.reservation.save!
    end
  end
end
