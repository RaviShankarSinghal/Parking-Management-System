class AdminPageController < ApplicationController
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
    @emp = Employee.pluck(:user_type)
    
    @employee = Employee.show
  end
  def new
    auth
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
    auth
    @employee = Employee.find(params[:id])
    @vec = @employee.vechiles.count()
    @v = @employee.vechiles.all
  end

  def edit
    auth
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
    auth
    @employee = Employee.find(params[:admin_page_id])
  end
  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to admin_page_index_path
  end
  def search
    auth
  end
  def search1
    @vec = Vechile.search(params[:q])
    if @vec
      redirect_to employee_show1_path(@vec.ids)
    else
      render ('search')
    end
  end
  private
  def employee_params
    params.require(:employee).permit(:name, :email, :password, :user_type)
  end
end
