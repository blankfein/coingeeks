class AddCharterTypeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :charter_type, :integer
  end
end
