class ReportsController < ApplicationController
  def index
    cutoff = Date.new(2020,3,31)

    @end_of_month_dates = []

    while cutoff < Date.today
      @end_of_month_dates << cutoff

      cutoff = (cutoff + 1.day).end_of_month
    end

    @end_of_month_dates << Date.today


    @user_counts_acc = @end_of_month_dates.map { |date|
    [date, User.where("created_at <= ?", date).count]
    }
    
    @project_counts_acc = @end_of_month_dates.map { |date|
      [date, Project.where("created_at <= ?", date).count]
    }

    @userpairedup_counts_acc = @end_of_month_dates.map { |date|
      [date, User.where("created_at <= ? and pair_with_projects = ?", date, "True").count]
    }

    @projectvolunteered_counts_acc = @end_of_month_dates.map { |date|
    [date, Volunteer.where("created_at <= ?", date).count('DISTINCT project_id')]
    }

    #cauculate per month counts
    @user_counts = []
    @project_counts = []
    @userpairedup_counts = []
    @projectvolunteered_counts = []

    @user_counts << @user_counts_acc[0][1]
    @project_counts << @project_counts_acc[0][1]
    @userpairedup_counts << @userpairedup_counts_acc[0][1]
    @projectvolunteered_counts << @projectvolunteered_counts_acc[0][1]

    @months_total = @user_counts_acc.length()
    for i in 1..(@months_total -1) do
      @user_counts << @user_counts_acc[i][1] - @user_counts_acc[i-1][1]
      @project_counts << @project_counts_acc[i][1] - @project_counts_acc[i-1][1]
      @userpairedup_counts << @userpairedup_counts_acc[i][1] - @userpairedup_counts_acc[i-1][1]
      @projectvolunteered_counts << @projectvolunteered_counts_acc[i][1] - @projectvolunteered_counts_acc[i-1][1]
    end

    @months_string = @end_of_month_dates.map { |date|
      [date.strftime()]
    }
    
    @user_total = User.count
    @project_total = Project.count
    @userpairedup_total = @userpairedup_counts_acc.last()[1]
    @projectvolunteered_total = @projectvolunteered_counts_acc.last()[1]

    @new_users = User.where("created_at >= ?", Date.today - 7).count
    @new_projects = Project.where("created_at >= ?", Date.today - 7).count

    @users_userspairedup_report = @user_counts_acc
    for i in 0..(@months_total -1) do
      @users_userspairedup_report[i] << @userpairedup_counts_acc[i][1]
    end

    @projects_projectvolunteered_report = @project_counts_acc
    for i in 0..(@months_total -1) do
      @projects_projectvolunteered_report[i] << @projectvolunteered_counts_acc[i][1]
    end

  end
end
