class ReportsController < ApplicationController
  def index
    cutoff = Date.new(2020,3,31)

    @dates = []

    while cutoff < Date.today
      @dates << cutoff

      cutoff = (cutoff + 1.day).end_of_month
    end

    @dates << Date.today

    @project_counts = @dates.map { |date|
      [date, Project.where("created_at <= ?", date).count]
    }

    @user_counts = @dates.map { |date|
    [date, User.where("created_at <= ?", date).count]
    }

    @user_project_counts = @dates.map { |date|
    [date, User.where("created_at <= ?", date).count, Project.where("created_at <= ?", date).count]
    }

  end

  
end
