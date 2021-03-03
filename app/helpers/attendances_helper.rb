module AttendancesHelper
  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
  def format_hour(time)
   format("%02d", time.hour)
  end
 
  def format_min(time)
    format("%02d", ((time.min) / 15) * 15)
  end
  
  def format_re_working_times(restart, refinish, change_next_day)
    if change_next_day == true
      format("%.2f",((refinish.hour - restart.hour) + ((((refinish.min - restart.min) /15) * 15) / 60.0)) + 24)
    else
      format("%.2f", (refinish.hour - restart.hour) + ((((refinish.min - restart.min) / 15) * 15) / 60.0))
    end
  end
 
end    

