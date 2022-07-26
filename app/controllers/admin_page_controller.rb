class AdminPageController < ApplicationController
  def index
    @employee = Employee.all
  end
  
  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:notice] = "Employee created successfully......"
      redirect_to admin_page_index_path
    else
      render('new')
    end
  end
  
  def show
    @employee = Employee.find(params[:id])
  end

  def edit
    @employee = Employee.find(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      flash[:notice] = "Employee details update successfully ....."
      redirect_to admin_page_path(@employee)
      
    else
      render ('edit')
    end
  end

  def delete
    @employee = Employee.find(params[:admin_page_id])
  end
  
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to admin_page_index_path
  end
  
  private
  def employee_params
    params.require(:employee).permit(:emp_id, :Name, :email, :password)
  end
  
  
end
