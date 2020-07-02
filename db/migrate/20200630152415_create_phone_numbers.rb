class CreatePhoneNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :phone_numbers do |t|
      t.string :number
      t.string :country_iso3166, index: true
      t.boolean :available

      t.timestamps
    end
  end
end
