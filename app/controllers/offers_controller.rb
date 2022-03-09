class OffersController < ApplicationController

    before_action :get_offer, only: [:edit, :show]
    before_action :get_project
    before_action :get_offers , only:[:show, :index]
    
    def index
      @offers = Offer.includes(:user, :project)
    
    
    end
    def show
      
    end
    def new

        @offer = Offer.new()

    end
    def edit
    end

    def create 
        @offer = @project.offers.new(offer_params)
        @offer.user_id =  current_user.id
        if @offer.save 
          redirect_to project_offers_path, notice: "offer successfully created"
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
        @offer = Offer.find(params[:id])
    end
    def offer_params
        params.require(:offer).permit(:message, :accept)
    end
    def get_project
      @project = Project.find(params[:project_id])
     end
     def get_offers
      @offers = current_user.offers.all
    end
end
