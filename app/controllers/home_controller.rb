class HomeController < ApplicationController
  def index
    unless session[:admin_id].blank?
      redirect_to admin_page_index_path
     end
     unless session[:employee_id].blank?
      redirect_to employee_index_path
     end
  end
  def login
  end
  def login2
    @employee = Employee.find_by(email: params[:email], password: params[:password])
    if @employee
     if @employee.user_type.upcase == "ADMIN"
       session[:admin_id]=@employee.id
       unless session[:admin_id].blank?
        redirect_to admin_page_index_path
       end
       
     elsif @employee.user_type.upcase == "EMPLOYEE"
       session[:employee_id] = @employee.id
       unless session[:employee_id].blank?
        redirect_to employee_index_path
       end
     else
       render 'index'
     end
    else
      render 'index'
    end
  end
  def delete_user
    session.delete(:admin_id)
    session.delete(:employee_id)
    redirect_to root_path
  end
end
