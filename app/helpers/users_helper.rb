module UsersHelper
  def format_basic_info(time)
    format("%.2f", ((time.hour * 60) + time.min) / 60.0)
  end
 
 
  def format_overtime(overtime, end_time, next_day)
    if next_day == true
        format("%.2f", (overtime.hour - end_time.hour) + (((((overtime.min - end_time.min) /15) *15 )/ 60.0)) + 24)
    else
        format("%.2f", (overtime.hour - end_time.hour) + (((((overtime.min - end_time.min) /15) *15 )/ 60.0)))
    end
  end

end 