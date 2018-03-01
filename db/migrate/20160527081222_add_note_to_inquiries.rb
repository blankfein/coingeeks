class AddNoteToInquiries < ActiveRecord::Migration
  def change
    add_column :inquiries, :note, :text, default: ""
  end
end
