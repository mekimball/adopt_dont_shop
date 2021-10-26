class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :good_home
      t.string :status, :default => 'In Progress'

      t.timestamps
    end
  end
end
