namespace :default_data do
  desc 'set default data'
  task set: :environment do
    exec "rake db:seed_fu FILTER=top_page_default_data,identification_type,bank"
  end

  desc 'set test_user_data ONLY FOR DEVELOPMENT'
  task test_user_data: :environment do
    exec "rake db:seed_fu FIXTURE_PATH=db/fixtures/development"
  end
end
