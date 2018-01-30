class CreateExcavators < ActiveRecord::Migration[5.1]
  def change
    create_table :excavators do |t|
      t.string  :company_name
      t.boolean :manned

      t.references :ticket
    end
  end
end
