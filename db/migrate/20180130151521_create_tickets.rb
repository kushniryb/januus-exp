class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.string     :request_id
      t.integer    :sequence_id
      t.string     :request_type
      t.string     :service_area
      t.string     :additional_service_areas, array: true, default: [], null: false
      t.datetime   :response_due_at
      t.st_polygon :locations
    end

    add_index :tickets, :additional_service_areas, using: :gin
    add_index :tickets, :locations,                using: :gist
  end
end
