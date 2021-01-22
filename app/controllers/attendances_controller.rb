class AttendancesController < ApplicationController
  before_action :set_user, only: [:edit_one_month, :update_one_month]
  before_action :logged_in_user, only: [:update, :edit_one_month]
  before_action :admin_or_correct_user, only: [:update, :edit_one_month, :update_one_month]
  before_action :set_one_month, only: :edit_one_month

  UPDATE_ERROR_MSG = "勤怠登録に失敗しました。やり直してください。"

  def update
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    # 出勤時間が未登録であることを判定します。
    if @attendance.started_at.nil?
      if @attendance.update_attributes(started_at: Time.current.change(sec: 0))
        flash[:info] = "おはようございます！"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    elsif @attendance.finished_at.nil?
      if @attendance.update_attributes(finished_at: Time.current.change(sec: 0))
        flash[:info] = "お疲れ様でした。"
      else
        flash[:danger] = UPDATE_ERROR_MSG
      end
    end
    redirect_to @user
  end

  def edit_one_month
    @month_check_superiors =  User.where(superior: true).where.not(id: @user.id)
  end

 
  def update_one_month
    
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      attendances_params.each do |id, item|
        if item[:month_check_superior].present?
          if item[:restated_at].present? && item[:refinished_at].blank?
           flash[:danger] = "退社時間がないので無効です"
           redirect_to attendances_edit_one_month_user_url(date: params[:date]) and return
          else
           if item[:note].blank?
              flash[:danger] = "備考欄を記入して下さい。" 
              redirect_to attendances_edit_one_month_user_url(date: params[:date]) and return
           else
             if item[:change_next_day] == "1"
               refinished_at = refinished_at.hour + 24
               attendance = Attendance.find(id)  
               attendance.update_attributes!(item)
             else
               attendance = Attendance.find(id)  
               attendance.update_attributes!(item)
             end   
           end   
          end
        end
      end #each do  
    end #Active record  
  flash[:success] = "1ヶ月分の勤怠変更を申請しました。"
  redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date]) and return
  end
 
 #1か月分の変更申請モーダル 
  def month_request
    @user = User.find(params[:user_id])
    @month_requesters = Attendance.where(month_check_superior: @user.name, month_status: "申請中").order(:user_id).group_by(&:user_id)
  end  
  
  #1か月分の勤怠変更モーダルupdate
  def update_month_request
    @user = User.find(params[:user_id])
    @month_requesters = Attendance.where(month_check_superior: @user.name, month_status: "申請中").order(:user_id).group_by(&:user_id)
    ActiveRecord::Base.transaction do 
      month_request_params.each do |id, item|
        if item[:month_checker] == "1" && item[:note].present?
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
        @approval_sum =  Attendance.where(month_status: "承認").count
        @unapproval_sum =  Attendance.where(month_status: "否認").count
        @no_reply =  Attendance.where(month_status: "なし").count
        flash[:success] = "なし#{@no_reply}件、承認#{@approval_sum}件、否認#{@unapproval_sum}件"
      end
     
      redirect_to user_url(@user)
    end
      
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "備考欄記入、またはチェックを記入して下さい。更新をキャンセルしました。"
    redirect_to user_url(@user)
  end
  
  def overtime_request
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    @superiors =  User.where(superior: true).where.not(id: @user.id)
  end  

  

  def update_overtime
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    
     # 更新失敗時の処理.
    if params[:attendance]["overtime(4i)"].blank? || params[:attendance]["overtime(5i)"].blank?      
      flash[:danger] = "#{@user.name}の残業時間を選択してください。 "
    elsif params[:attendance][:superior].blank?
      flash[:danger] = "#{@user.name}の指示者を選択して下さい。 "
    else
      params[:attendance][:status] = "申請中"
      @attendance.update_attributes(overtime_params)
      flash[:success] = "#{@user.name}の残業申請をしました。"
    end 
    redirect_to user_url(@user)
  end  
  
  
  #申請モーダル      
  def overtime_request_info 
     @user = User.find(params[:user_id])
     @requesters = Attendance.where(superior: @user.name, status: "申請中").order(:user_id).group_by(&:user_id)
  end 
  
  
  #申請一覧モーダルのupdate
  def update_overtime_request_info
    @user = User.find(params[:user_id])
    ActiveRecord::Base.transaction do 
      overtime_request_info_params.each do |id, item|
        if item[:superior_checker] == "1"
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
           @info_sum = Attendance.where(status: "承認").count
           @unapproval_info_sum = Attendance.where(status: "否認").count
           @no_reply_info = Attendance.where(status: "なし").count
           flash[:success] = "なし#{@no_reply_info}件、承認#{@info_sum}件、否認#{@unapproval_info_sum}件"
        end #if end 
      end #each end 
      redirect_to user_url(@user)
    end #Acctive do end    
  
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
  flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
  end #def end
  
  def update_total_month
    @user = User.find(params[:id])
    @attendance = Attendance.find_by(worked_on: params[:user][:worked_on])
   if params[:user][:total_month_superior].blank?
      flash[:danger]= "所属長を選択してください。"
   else    
    params[:user][:total_month_status] = "申請中"
    @attendance.update_attributes(total_month_params)
    flash[:success] = "#{@user.name}の1か月分の申請をしました。"
   end 
    redirect_to user_url(@user)
  end     
 
 
  def approval_month
     @user = User.find(params[:user_id])
     @approval_requesters = Attendance.where(total_month_superior: @user.name, total_month_status: "申請中").order(:user_id).group_by(&:user_id)
  end
  
  
  def update_approval_month
    @user = User.find(params[:user_id])
    ActiveRecord::Base.transaction do
      approval_params.each do |id, item|
        if item[:total_month_checker] == "1"
           attendance = Attendance.find(id)
           attendance.update_attributes!(item)
           @approval_sum2 = Attendance.where(total_month_status: "承認").count
           @unapproval_sum2 = Attendance.where(total_month_status: "否認").count
           @no_reply2 = Attendance.where(total_month_status: "なし").count
           flash[:success] = "なし#{@no_reply2}件、承認#{@approval_sum2}件、否認#{@unapproval_sum2}件"
        else
          flash[:danger] = "チェックを記入して下さい"
        end
      end
    end   
     redirect_to user_url(@user)
    
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
  flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
  end  
  
  def log_page
   @user = User.find(params[:user_id])
   @attendance = Attendance.find(params[:user_id])
    #@overtime_days = Attendance.where(status: "承認")
  end  
  
  def update_log_page
    @user = User.find(params[:user_id])
    ActiveRecord::Base.transaction do 
      log_params.each do |id, item|
         attendance = Attendance.find(id)
         attendance.update_attributes!(item)
      end #each end 
      redirect_to user_url(@user)
    end #Acctive do end 
  end  
      
 
  
  private
    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:change_next_day, :restated_at, :refinished_at, :note, :month_check_superior, :month_status])[:attendances]
    end
    #overtime(残業申請の内容)の更新カラム
    def overtime_params
      params.require(:attendance).permit(:overtime, :next_day, :task_menu, :superior, :status)
    end
    
    def overtime_request_info_params
      params.require(:user).permit(attendances: [:overtime, :status, :superior_checker])[:attendances]
    end
    
    def month_request_params #1ヶ月分の勤怠変更を扱います。
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note, :month_status, :month_check_superior, :month_checker, :restated_at, :refinished_at])[:attendances]
    end
    
    def total_month_params #1ヶ月分の勤怠申請を扱います
       params.require(:user).permit(:worked_on, :total_month_superior, :total_month_status)
    end  
    def approval_params
      params.require(:user).permit(attendances: [:total_month_status, :total_month_checker])[:attendances]
    end
   
    def log_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note, :month_status, :month_check_superior, :month_checker, :restated_at, :refinished_at])[:attendances]

    end
end

