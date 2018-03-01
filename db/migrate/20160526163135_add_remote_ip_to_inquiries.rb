class AddRemoteIpToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :remote_ip, :string, null: false, default: ""
  end
end
