class AdminPageController < ApplicationController
  def index
    @employee = Employees.all
  end
  
  def new
    @employee = Employees.new
  end

  def create
    @employee = Employees.new(employee_params)
    if @employee.save
      flash[:notice] = "Employee created successfully......"
      redirect_to new_admin_page_path
    else
      render('new')
    end
  end
  
  def show
    @employee = Employees.find(params[:id])
  end

  def edit
    @employee = Employees.find(params[:id])
  end
  
  def update
    @employee = Employees.find(params[:id])
    if @employee.update(employee_params)
      flash[:notice] = "Employee details update successfully ....."
      redirect_to edit_admin_page_path(@employee)
      
    else
      render ('edit')
    end
  end

  def delete
    @employee = Employees.find(params[:id])
  end
  
  def destroy
    @employee = Employees.find(params[:id])
    @employee.destroy
    redirect_to admin_page_delete_path
  end
  
  private
  def employee_params
    params.require(:employees).permit(:name, :email, :password)
  end
  
  
end
