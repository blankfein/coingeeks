# Sample Host user and listing (user1@example.com)
host = FactoryGirl.create(:user)
FactoryGirl.create_list(:opened_listing, 3, user: host)
FactoryGirl.create(:bank_account, profile: host.profile)

# Sample Guest user and reservation (Guest email: user2@example.com)
guest = FactoryGirl.create(:user)
FactoryGirl.create(:reservation, listing: Listing.first, host: host, guest: guest)
FactoryGirl.create(:bank_account, profile: guest.profile)

# Other Sample Datas
FactoryGirl.create_list(:opened_listing, 3)

FactoryGirl.create_list(:requested_reservation, 3)
FactoryGirl.create_list(:accepted_reservation, 3)

FactoryGirl.create_list(:review, 3)
FactoryGirl.create_list(:review_reply, 3)
