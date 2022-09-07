class EmployeeController < ApplicationController
  def auth
    begin
      if session[:employee_id].blank? && session[:admin_id].blank?
        raise "what"
      end
    rescue
      redirect_to root_path
    end
  end
  def index
    auth
    unless session[:employee_id].blank?
      @employee = Employee.find(session[:employee_id])
      @floor = @employee.floor.first
      unless @floor.blank?
        @slot = @floor.slots.where(parking_status: "full")
      end
      
    end
  end
  def new
    auth
    @employee = Employee.find(session[:employee_id])
    @floor = @employee.floor.first
    @slot = @floor.slots.where(parking_status: "empty").first
    @vec = @slot.vechiles.new unless @slot.blank?
  end
  def create
    @employee = Employee.find(session[:employee_id])
    @floor = @employee.floor.first
    @slot = @floor.slots.where(parking_status: "empty").first
    @vec = @slot.vechiles.build(vehicles_params)
    if @vec.save
      @slot.update(parking_status: "full")
      redirect_to employee_index_path
    else
      render 'index'
    end
  end
  def show
    auth
    @employee = Employee.find(session[:employee_id])
    @floor = @employee.floor.first
    @slot = @floor.slots.first
    @vec = Vechile.find(params[:id])
  end
  def edit
    auth
    @employee = Employee.find(session[:employee_id])
    @floor = @employee.floor.first
    @slot = @floor.slots.first
    @vec = Vechile.find(params[:id])
    @vec.created_at = @vec.created_at.strftime("%Y-%m-%d %H:%M:%S")
    @vec.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
  def update
    @employee = Employee.find(session[:employee_id])
    @floor = @employee.floor.first
    @slot = @floor.slots.first
    @vec  = Vechile.find(params[:id])
    @vec.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    if @vec.update(vehicles_params)
      @vec.price = (100 * total_time(@vec))
      @slot.update(parking_status: "empty")
      redirect_to employee_index_path(@vec)
    else
      render ('edit')
    end
  end

  def destroy
    auth
    @employee = Employee.find(session[:employee_id])
    @vec = Vechile.find(params[:id])
    @slot = Slot.find(@vec.slot_id)
    @slot.update(parking_status: "empty")
    @vec.destroy
    redirect_to employee_index_path
  end

  def show1
    auth
    @employee = Employee.find(params[:employee_id])
    @vec = @slot.vechile.search(params[:id])
  end
  
  private
  def vehicles_params
    params.require(:vechile).permit(:number, :car_model_name, :created_at, :updated_at)
  end
  def vec
    @vec  = Vechile.find(params[:id])
  end
  def total_time(vec)
    check_date = vec.updated_at.strftime('%d').to_i - vec.created_at.strftime('%d').to_i
    #if data change so we calculate total hours and minutes
    if check_date > 0
        total_hours = 24 + vec.updated_at.strftime('%H').to_i - vec.created_at.strftime('%H').to_i
    else
        total_hours = vec.updated_at.strftime('%H').to_i - vec.created_at.strftime('%H').to_i
    end
    if total_hours > 0
        total_min = 60 + vec.updated_at.strftime('%M').to_i - vec.created_at.strftime('%M').to_i
    else
        total_min = vec.updated_at.strftime('%M').to_i - vec.created_at.strftime('%M').to_i
    end
    if check_date > 0
        if total_min > 0
            total_hours = total_hours + 1
        else
            total_hours
        end
    else
        if total_min > 0
            total_hours = total_hours + 1
        else
            total_hours
        end
    end
end
end
