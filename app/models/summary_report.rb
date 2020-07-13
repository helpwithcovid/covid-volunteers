class SummaryReport
  def initialize()

    #create end of month date starting from the beginning of the project to doday
    cutoff = Date.new(2020,3,31)
    @end_of_month_dates = []

    while cutoff < Date.today
      @end_of_month_dates << cutoff

      cutoff = (cutoff + 1.day).end_of_month
    end
    @end_of_month_dates << Date.today

    #create total count
    @user_count = User.all.count
    @volunteered_user_count = User.where("pair_with_projects = ?","True").count
    @new_user_count = User.where("created_at >= ?", Date.today - 7).count
    @project_count = Project.all.count
    @volunteered_project_count = Volunteer.count('DISTINCT project_id')
    @new_project_count = Project.where("created_at >= ?", Date.today - 7).count

    #create input arrays for the user and project table, 
    #counts the total for each end of month
 
    @user_table = @end_of_month_dates.map { |date|
      [date, User.where("created_at <= ?", date).count,
      User.where("created_at <= ? and pair_with_projects = ? ", date, "True").count]
    }

    @project_table = @end_of_month_dates.map { |date|
      [date, Project.where("created_at <= ?", date).count,
      Volunteer.where("created_at <= ?", date).count('DISTINCT project_id')]
    }

    #create input for graphs, total for each month
    @user_count_per_month = @end_of_month_dates.map { |date|
      bom = date.beginning_of_month
      eom = date.end_of_month
      User.where("created_at >= ? and created_at <= ?", bom, eom).count
    }

    @volunteered_user_count_per_month = @end_of_month_dates.map { |date|
      bom = date.beginning_of_month
      eom = date.end_of_month
      User.where("created_at >= ? and created_at <= ? and pair_with_projects = ? ", bom, eom, "True").count
    }
    @project_count_per_month = @end_of_month_dates.map { |date|
      bom = date.beginning_of_month
      eom = date.end_of_month
      Project.where("created_at >= ? and created_at <= ?", bom, eom).count
    }
    @volunteered_project_count_per_month = @end_of_month_dates.map { |date|
      bom = date.beginning_of_month
      eom = date.end_of_month
      Volunteer.where("created_at >= ? and created_at <= ?", bom, eom).count('DISTINCT project_id')
    }

    @month_labels = @end_of_month_dates.map { |e| e.strftime("%B") }

  end

  attr_reader :user_count, :volunteered_user_count, :new_user_count, 
    :project_count, :volunteered_project_count, :new_project_count,
    :user_table, :project_table, 
    :user_count_per_month, :volunteered_user_count_per_month, 
    :project_count_per_month, :volunteered_project_count_per_month,
    :month_labels


end