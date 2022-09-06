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
      @slot = @floor.slots.where(parking_status: "full")
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
      @slot.update(parking_status: "empty")
      redirect_to employee_index_path(@vec)
    else
      render ('edit')
    end
  end

  def destroy
    auth
    @employee = Employee.find(session[:employee_id])
    @floor = @employee.floor.first
    @slot = @floor.slots.first
    @vec = @slot.vechiles.first
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
end
