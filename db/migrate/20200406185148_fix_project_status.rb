class FixProjectStatus < ActiveRecord::Migration[6.0]
  def change
    Project.where(status: 'Actively recruiting').update_all(accepting_volunteers: true, status: Settings.project_statuses[1])
  end
end
