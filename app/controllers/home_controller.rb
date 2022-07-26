class HomeController < ApplicationController
  def index
  end
  def login
  end
  def login2
    @admin = Admin.find_by(email: params[:email], password: params[:password])
   if @admin
    session[:admin_id]=@admin.id
    redirect_to admin_path
   else
    flash[:notice] = "Invalid Credentials"
    render 'index'
   end
  end
end
