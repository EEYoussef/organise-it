class OffersController < ApplicationController

    before_action :get_offer, only: [:edit, :show]
    before_action :get_project
    
    def show
    end
    def new
        @offer = Offer.new()
    end
    def edit
    end

    def create 
        @offer = current_user.projects.offer.new(offer_params)
        if @offer.save 
          redirect_to @project, notice: "offer successfully created"
        else
         
          render "new", notice: "Something went wrong"
        end 
    end 

    def authorize_user 
        if @project.user_id != current_user.id
          flash[:alert] = "You don't have permission to do that"
          redirect_to projects_path
        end 
    end 

    def get_offer
        @offer = Projects.Offer.find(params[:project_id])
    end
    def offer_params
        params.require(:offer).permit(:message, :accept)
    end
    def get_project
      @project = Project.find(params[:project_id])
     end
end
