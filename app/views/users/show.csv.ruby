require 'csv'

CSV.attendance do |csv|
  column_names = %w(worked_on started_at finished_at)
  csv << column_names
  @attendances.each do |attendance|
    column_values = [
      attendance.worked_on,
      attendance.started_at,
      attendance.finished_at
    ]
    csv << column_values
  end
end
