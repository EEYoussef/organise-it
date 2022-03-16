class ProjectOutcomesController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :get_project_outcome, only: [:show, :edit, :update, :destroy]
  before_action :get_project_outcomes, only: [:index]
  #to check if the project has been accepted
  before_action :check_acceptance
  #To allow users who created the project only to edit in them 
  before_action :authorize_user, only: [:edit, :update, :destroy]
  
  
  def index
    
    if @project_outcomes.empty?
      flash[:alert] = "This project doesnt have outcome yet"
    end
  end

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email:current_user && current_user.email, 
      line_items: [
        {
          name: @project.title,
          description: @project.description,
          amount: @project.price, 
          currency: 'aud',
          quantity: 1
        }
      ],
      payment_intent_data: {
        metadata: {
          user_id: current_user && current_user.id, 
          project_id: @project.id
        }
      },
      success_url: "#{root_url}payments/success/#{@project.id}",
      cancel_url: root_url
    )

    @session_id = session.id
  end

  def new 
    @project_outcome =ProjectOutcome.new
  end 
# the action to create the project
  def create 
    @project_outcome = @project.project_outcomes.new(project_outcome_params)
    if @project_outcome.save 
       redirect_to project_project_outcome_path(@project.id,@project_outcome), notice: "outcome successfully created"
      
    else
     
      render "new", notice: "Something went wrong"
    end 
  end 

  def update
  end

  def authorize_user 
    if @project.user_id != current_user.id
      flash[:alert] = "You don't have permission to do that"
      redirect_to projects_path
    end 
end 

  def set_project
    @project = Project.find(params[:project_id])
  end
  
  def project_outcome_params
    params.require(:project_outcome).permit(:title, :details)
  end
  def check_acceptance
    # offer_acceptance = @project.offers.find(user_id: current_user.id)
    @project = Project.find(params[:project_id])
    offer_acceptance = @project.offers.where(user_id: current_user.id)
  end 
  def get_project_outcome
    @project_outcome = ProjectOutcome.find(params[:id])
  end
  def get_project_outcomes
    @project_outcomes = ProjectOutcome.where(project_id: params[:project_id])
  end
end
