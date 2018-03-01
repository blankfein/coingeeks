class CreateBankAccountTypes < ActiveRecord::Migration
  def change
    create_table :bank_account_types do |t|
      t.string :name, null: false
      t.boolean :available, default: true

      t.timestamps null: false
    end
    add_index :bank_account_types, :name, unique: true
  end
end
