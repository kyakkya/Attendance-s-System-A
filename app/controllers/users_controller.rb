class UsersController < ApplicationController
  before_action :set_user, only: [:show, :comfirmation, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:edit, :update, :destroy, :edit_basic_info, :update_basic_info, :overtime_request]
  before_action :correct_user, only: [:edit, :update, :show]
  before_action :admin_user, only: [:index, :destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show  
  before_action :admin_or_correct_user, only: [:index, :show]
   
  def index
    @users = User.where.not(id: 1)
  end
  
  def import
    # fileはtmpに自動で一時保存される
     if params[:csv_file] .blank?
      flash[:danger]= "csvファイルを選択してください"
      redirect_to users_url
     else    
      User.import(params[:csv_file])
      flash[:success]= "インポートしました"
      redirect_to users_url
     end  
  end
  
  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
    @request_sum = Attendance.where(superior: @user.name).where(status: "申請中").count
    @change_sum =  Attendance.where(month_check_superior: @user.name).where(month_status: "申請中").count
    @total_superiors =  User.where(superior: true).where.not(id: @user.id)
    @total_month_sum =  Attendance.where(total_month_superior: @user.name).where(total_month_status: "申請中").count
    
    # csv出力
    respond_to do |format|
      format.html 
      format.csv do
        send_data render_to_string, filename: "勤怠一覧表.csv", type: :csv    #csv用の処理を書く
      end
    end
  end
  
  def comfirmation
    @user = User.find (params[:id])
    @first_day = params[:day].to_date.beginning_of_month
    @last_day = @first_day.end_of_month
    @attendances = @user.attendances.where(worked_on: @first_day..@last_day)
    @status_sum = Attendance.where(status: "申請中").count
    @worked_sum = @attendances.where.not(started_at: nil).count
  end  

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
       log_in @user # 保存成功後、ログインします。
       flash[:success] = '新規作成に成功しました。'
       redirect_to @user
    else
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit      
    end
  end
   
  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end
   
  def edit_basic_info
  end
   
  def update_basic_info
   if @user.update_attributes(basic_info_params)
       flash[:success] = "#{@user.name}の基本情報を更新しました。"  
   else
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
   end
      redirect_to users_url
  end
   
  def employees_on_duty
    @users = User.joins(:attendances).where.not(attendances: {started_at: nil}).where(attendances:{finished_at: nil})
  end
       
   
   


  private

    def user_params
      params.require(:user).permit(:name, :email, :affiliation, :password, :password_confirmation, 
      :employee_number, :uid, :basic_work_time, :designated_work_start_time, :designated_work_end_time)
    end
    
    def basic_info_params
      params.require(:user).permit( :email,:affiliation,  :password, :password_confirmation, 
      :employee_number, :uid, :basic_time, :work_time, :basic_work_time, :designated_work_start_time, 
      :designated_work_end_time)
    end
    
   
    
    # アクセスしたユーザーが現在ログインしているユーザーか確認します。
    def correct_user
      
      redirect_to(root_url) unless current_user?(@user)
    end
    
    def admin_user
      redirect_to root_url unless current_user.admin?
    end  
end