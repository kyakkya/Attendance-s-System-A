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
  
  def re_working_times(restat, refinish, change_next)
    if change_next == "1"
       format("%.2f", (refinish.hour - restat.hour) + (((((refinish.min - restat.min) /15) *15 )/ 60.0)) + 24)
    else
       format("%.2f", ((refinish.hour - restat.hour) + ((((((refinish.min - restat.min) /15) *15 )/ 60.0)))))
    end
  end
 
end    

