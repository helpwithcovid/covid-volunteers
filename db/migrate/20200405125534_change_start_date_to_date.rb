class ChangeStartDateToDate < ActiveRecord::Migration[6.0]
  def up
    change_column :projects, :start_date, :date, using: 'start_date::DATE', default: nil
    change_column :projects, :end_date, :date, using: 'start_date::DATE', default: nil
  end

  def down
    change_column :projects, :start_date, :string
    change_column :projects, :end_date, :string
  end
end
