module HomeHelper
  def round_number_to_closest(number, group_size)
    if number > group_size
      (number / group_size).floor * group_size
    else
      number
    end
  end
end
