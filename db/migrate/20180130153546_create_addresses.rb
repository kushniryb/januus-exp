class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :state
      t.string :city
      t.string :zip_code

      t.references :excavator
    end
  end
end
