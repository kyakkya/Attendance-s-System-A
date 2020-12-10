module UsersHelper
 def format_basic_info(time)
   format("%.2f", ((time.hour * 60) + time.min) / 60.0)
 end
 
 def format_overtime(time)
   format("%.2f", ((time.hour * 60) + time.min) / 60.0)
 end   
  
 def format_overtime_m 
   format("%2d", (time.min / 15) * 15)
 end

end 