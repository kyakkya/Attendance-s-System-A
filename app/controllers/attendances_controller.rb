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
  end

  def update_one_month
    ActiveRecord::Base.transaction do # トランザクションを開始します。
      attendances_params.each do |id, item|
        if item[:started_at].present? && item[:finished_at].blank?
          flash[:danger] = "退勤時間がないので無効です"  
        else  
          attendance = Attendance.find(id)
          attendance.update_attributes!(item)
        end
      end  
    end  
    flash[:success] = "1ヶ月分の勤怠情報を更新しました。"
    redirect_to user_url(date: params[:date])
  rescue ActiveRecord::RecordInvalid # トランザクションによるエラーの分岐です。
    flash[:danger] = "無効な入力データがあった為、更新をキャンセルしました。"
    redirect_to attendances_edit_one_month_user_url(date: params[:date])and return
  end

  def overtime_request
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    @superiors =  User.where(superior: true).where.not(id: @user.id)
  end  

  

  def update_overtime
    @user = User.find(params[:user_id])
    @attendance = Attendance.find(params[:id])
    if  @attendance.update_attributes(overtime_params)
       # 更新成功時の処理
      flash[:success] = "#{@user.name}の残業申請をしました。"
    else
        # 更新失敗時の処理
    　flash[:danger] = "#{@user.name}の残業申請は失敗しました。"    
    end
    
    redirect_to user_url(@user)
  
  end
  
  
  
  private
    # 1ヶ月分の勤怠情報を扱います。
    def attendances_params
      params.require(:user).permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
    #overtime(残業申請の内容)の更新カラム
    def overtime_params
      params.require(:attendance).permit(:overtime, :next_day, :task_menu, :superior)
    end 
    
end