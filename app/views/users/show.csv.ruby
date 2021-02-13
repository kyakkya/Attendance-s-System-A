require 'csv'


CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  column_names = %w(日付 曜日  出社時間  退勤時間)
  day_of_the_week = ["日", "月", "火", "水", "木", "金", "土"]
  csv << column_names
  @attendances.each do |day|
    column_values = [
      day.worked_on.strftime('%m/%d'),
      day_of_the_week[day.worked_on.wday],
      day&.started_at&.strftime('%H:%M'), 
      day&.finished_at&.strftime('%H:%M')
    ]
    
    csv << column_values
 
 end
end