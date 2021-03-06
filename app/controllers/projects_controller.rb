class ProjectsController < ApplicationController
  #this before action allows user only to access the features of the app 
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  #To allow users who created the project only to edit in them 
  before_action :authorize_user, only: [:edit, :update, :destroy]
  before_action :check_sold, only: [:edit, :update, :destroy]

  def index
    @projects = Project.all
  end

  def show
  end
  
  def new 
    @project = Project.new
  end 
# the action to creates the project
  def create 
    @project = current_user.projects.new(project_params)
    if @project.save 
       redirect_to @project, notice: "project successfully created"
      
    else
      
      @project.errors.full_messages.each do |message|
        flash[:alert] = message
      end
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
   
  # check if the offer has been accepted if yes the offer has to be done first.
    if @project.offers.where(accept: false).empty?
      @project.destroy
      redirect_to projects_path, notice: "Succesfully deleted"
      flash[:notice] = "Succesfully deleted"
    else
      flash[:alert] = "This offer cannot be deleted.... this offer has been accepted"
    end
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
    params.require(:project).permit(:title, :description, :budget, :price ,:freelancer_user_id,  pictures: [])
  end
  # to check if the project has been sold
  def check_sold
    if @project.sold
      flash[:alert] = "This project is already sold "
      redirect_to projects_path
    end 
  end
 
end
