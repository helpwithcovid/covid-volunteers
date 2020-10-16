class ChangeStartDateToDate < ActiveRecord::Migration[6.0]
  def up
    change_column :projects, :start_date, 'date USING CAST(case when start_date = \'\' then null else start_date end AS date)', default: nil
    change_column :projects, :end_date, 'date USING CAST(case when end_date = \'\' then null else end_date end AS date)', default: nil
  end

  def down
    change_column :projects, :start_date, :string
    change_column :projects, :end_date, :string
  end
end
