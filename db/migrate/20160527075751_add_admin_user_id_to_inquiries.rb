class AddAdminUserIdToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :admin_user_id, :integer
  end
end
