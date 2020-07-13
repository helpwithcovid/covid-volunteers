class ReportsController < ApplicationController
  def index
    @report = SummaryReport.new
  end
end
