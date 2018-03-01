class AddIdentificationTypeIdToIdentification < ActiveRecord::Migration
  def change
    add_column :identifications, :identification_type_id, :integer
  end
end
