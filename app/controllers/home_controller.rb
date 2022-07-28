class HomeController < ApplicationController
  def index
  end
  def login
  end
  def login2
    @employee = Employee.find_by(email: params[:email], password: params[:password])
    if @employee
     if @employee.user_type.upcase == "ADMIN"
       session[:admin_id]=@employee.id
       redirect_to admin_page_index_path
     elsif @employee.user_type.upcase == "EMPLOYEE"
       session[:employee_id] = @employee.id
       redirect_to employee_index_path
     else
       render 'index'
     end
    else
      render 'index'
    end
  end
end
