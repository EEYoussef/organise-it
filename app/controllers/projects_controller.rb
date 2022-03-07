class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  #To allow users who created the project only to edit in them 
  before_action :authorize_user, only: [:edit, :update, :destroy]
 
  def index
    @projects = Project.all
  end

  def show
  end
  # to see the form
  def new 
    @project = Project.new
  end 
# the action to create the project
  def create 
    @project = current_user.projects.new(project_params)
    if @project.save 
       redirect_to @project, notice: "project successfully created"
      
    else
     
      render "new", notice: "Something went wrong"
    end 
  end 
# for the user to edit the project/and action for updateing
  def edit
  end
  def update
    @project.update(project_params)
    if @project.save 
      redirect_to @project, notice: "Project successfully updated"
    else
      render "edit", notice: "Something went wrong"
    end 
  end

  def destroy
  end

  
  def authorize_user 
    if @project.user_id != current_user.id
      flash[:alert] = "You don't have permission to do that"
      redirect_to projects_path
    end 
end 
  def set_project
    @project = Project.find(params[:id])
  end
  
  def project_params
    params.require(:project).permit(:title, :description, :budget, :price, :picture ,:freelancer_user_id)
  end
end
