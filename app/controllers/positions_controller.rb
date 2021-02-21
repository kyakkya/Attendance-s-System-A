class PositionsController < ApplicationController
  before_action :set_position, only: [:show, :edit, :update, :destroy]

  # GET /positions
  # GET /positions.json
  def index
    @positions = Position.all
  end

  # GET /positions/1
  # GET /positions/1.json
  def show
  end

  # GET /positions/new
  def new
    @position = Position.new
  end

  # GET /positions/1/edit
  def edit
     @position = Position.find(params[:id])
  end

  # POST /positions
  # POST /positions.json
  def create
    @position = Position.new(position_params)
     if @position.save
       flash[:success] = '作成に成功しました。'
       redirect_to positions_url
     else
      flash[:danger] = "拠点情報を追加に失敗しました。"
      redirect_to positions_url   
     end
  end
   

  # PATCH/PUT /positions/1
  # PATCH/PUT /positions/1.json
  def update
    @position = Position.find(params[:id])
    if @position.update_attributes(position_params)
       flash[:success] = "拠点情報を更新しました。"# 更新に成功した場合の処理を記述します。
       redirect_to positions_url
    else
      flash[:danger] = "拠点情報を追加に失敗しました。"
      redirect_to positions_url
           
    end
  end  
    
    # DELETE /positions/1
  # DELETE /positions/1.json
  def destroy
    @position.destroy
    flash[:success] = "拠点地情報を削除しました。"
    redirect_to positions_url
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_position
      @position = Position.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def position_params
      params.require(:position).permit( :place_num, :place_name, :place_status )
    end
end 
