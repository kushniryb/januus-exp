class RenameTicketLocationsToZone < ActiveRecord::Migration[5.1]
  def change
    rename_column :tickets, :locations, :zone
  end
end
