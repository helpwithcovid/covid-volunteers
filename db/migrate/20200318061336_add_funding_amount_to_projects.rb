class AddFundingAmountToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :funding_amount, :integer
  end
end
