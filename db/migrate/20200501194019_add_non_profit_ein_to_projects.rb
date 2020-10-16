class AddNonProfitEinToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :ein, :string
  end
end
