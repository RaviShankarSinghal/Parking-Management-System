class EmployeeController < ApplicationController
  def index
    @employees = Employee.find(session[:employee_id])
    @vec = @employees.vechiles.all

  end
  def new
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.new
  end
  
  def create
    
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.build(vehicles_params)
    if @vec.save
      redirect_to employee_index_path
    else
      render 'index'
    end
  end
  def show
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.find(params[:id])
  end

  def destroy
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.find(params[:id])
    if @vec.destroy
      redirect_to employee_index_path
    else
      render 'index'
    end
  end
  
  private
  def vehicles_params
    params.require(:vechile).permit(:number, :car_model_name)
  end
end
