require 'csv'

@attendances = @user.attendances.find_by(worked_on: @first_day)
CSV.generate do |csv|
  column_names = %w(worked_on started_at finished_at )
  csv << column_names
  @attendances.each do |day|
    
    column_values = [
      day.worked_on,
      day.started_at,
      day.finished_at
    ]
    
    csv << column_values
 
 end
end