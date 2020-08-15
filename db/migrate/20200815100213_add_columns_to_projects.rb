class AddColumnsToProjects < ActiveRecord::Migration[6.0]
  def change
  		change_table :projects do |t|
  	    t.column :address, :text, null: true
  	    t.column :phone, :bigint, null: true
  	    t.column :longitude, :decimal, null: true
  	    t.column :latitude, :decimal, null: true
  	    t.column :multiple_locations, :boolean, null: true
  		end
    end
end
