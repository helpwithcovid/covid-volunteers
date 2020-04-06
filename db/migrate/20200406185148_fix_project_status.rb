class FixProjectStatus < ActiveRecord::Migration[6.0]
  def change
    Project.where(status: 'Actively recruiting').update_all(accepting_volunteers: true, status: ALL_PROJECT_STATUS[1])
  end
end
