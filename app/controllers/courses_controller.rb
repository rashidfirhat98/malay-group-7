class CoursesController < ApplicationController
  before_action :find_course, except: %i(index new create)

  def index
    @course = Course.page(params[:page]).per Settings.paging.course
  end

  def show; end
  
  def new
    @course = Course.new
  end

  def edit; end

  def create
    @course = Course.new course_params
    if @course.save
      flash[:info] = "Course created"
      redirect_to courses_path
    else
      flash[:danger] = "Please try again!"
      render :new
    end
  end

  def update
    if @course.update_attributes course_params
      flash[:success] = "Course updated"
      redirect_to @course
    else
      render :edit
      flash[:danger] = "Please try again!"
    end
  end

  def destroy
    if @course.ongoing? | @course.finished?
      redirect_to courses_path
      flash[:danger] = "Cannot delete course" 
    else
      @course.destroy
      flash[:success] = "Course deleted"
      redirect_to courses_path
    end
  end

  private

  def course_params
    params.require(:course).permit :name, :description, :started_at, :total_month, :total_member, :status
  end

  def find_course
    @course = Course.find_by id: params[:id]
    return if @course

    flash[:danger] = "Course not found!"
    redirect_to courses_path
  end
end
