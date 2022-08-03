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

  def edit
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.find(params[:id])
    @vec.created_at = @vec.created_at.strftime("%Y-%m-%d %H:%M:%S") 
    @vec.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
  end
  
  def update
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.find(params[:id])
    @vec.updated_at = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    if @vec.update(vehicles_params)
      redirect_to employee_index_path(@vec)
      
    else
      render ('edit')
    end
  end

  def destroy
    @employee = Employee.find(session[:employee_id])
    @vec = @employee.vechiles.find(params[:id])
    @vec.destroy
    redirect_to employee_index_path
      
  end

  def show1
    @employee = Employee.find(params[:employee_id])
    @vec = @employee.vechiles.find(params[:employee_id])
  end
  
  
  private
  def vehicles_params
    params.require(:vechile).permit(:number, :car_model_name, :created_at, :updated_at)
  end
end
