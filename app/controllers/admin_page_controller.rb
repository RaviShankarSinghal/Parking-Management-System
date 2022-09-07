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
    @floor = @employee.floor.first
    unless @floor.blank?
      @f = Floor.find_by(employee_id: @employee.id)
      @slot = @floor.slots.where(parking_status: "full")
      @vec = @slot.count()
    else
      @vec = 0
    end
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
  def newfloor
    auth
  end
  def createfloor
    if params[:number].to_i > 1
      params[:number].to_i.times do |j|
          @floor = Floor.find_by(number: j+1)
          if @floor.blank?
            @floor = Floor.new(number: j+1)
            if @floor.save
              10.times{
                |i|
                @slot = @floor.slots.create(slot_number: i+1)
              }
              flash[:notice] = "Successfully Assigned..."
              redirect_to admin_page_index_path
            else
              redirect_to admin_page_index_path
            end
          end
      end
    else
      @floor = Floor.find_by(number: params[:number])
      if @floor.blank?
        @floor = Floor.new(number: params[:number])
        if @floor.save
          10.times{
            |i|
            @slot = @floor.slot.create(number: i)
          }
        else
          redirect_to admin_page_index_path
        end
      else
        flash[:notice] = "Floor are already present"
      end
    end
  end
  def newslot
    auth
  end
  def createslot
    @floor = Floor.find_by(number: params[:number])
    if params[:slot_number].to_i > 1
      params[:slot_number].to_i.times{
        |i|
        @slot = @floor.slots.find_by(slot_number: i+1)
        if @slot.blank?
          @slot = @floor.slots.create(slot_number: i+1)
        end
      }
    else
      @slot = @floor.slots.find_by(slot_number: params[:slot_number])
      if @slot.blank?
        @slot = @floor.slots.create(slot_number: params[:slot_number])
      end
    end
  end

  def assignfloor
    auth
  end

  def assign_floor
    @employee = Employee.find_by(email: params[:email])
    @floor = Floor.find_by(number: params[:number])
    if @floor.update(employee_id: @employee.id)
      flash[:notice] = "Employee floor details update successfully ....."
      redirect_to admin_page_path(@employee)
    else
      render ('assignfloor')
    end
  end

  private
  def employee_params
    params.require(:employee).permit(:name, :email, :password, :user_type)
  end
end
