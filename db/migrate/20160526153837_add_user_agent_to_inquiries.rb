class AddUserAgentToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :user_agent, :string, null: false, default: ""
  end
end
