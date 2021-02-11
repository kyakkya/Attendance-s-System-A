require 'csv'


CSV.generate(encoding: Encoding::SJIS, row_sep: "\r\n", force_quotes: true) do |csv|
  column_names = %w(日付  出社時間  退勤時間)
  csv << column_names
  @attendances.each do |day|
    column_values = [
      l(day.worked_on, format: :middle),
      day&.started_at&.strftime('%H:%M'), 
      day&.finished_at&.strftime('%H:%M')
    ]
    
    csv << column_values
 
 end
end