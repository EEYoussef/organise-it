class OffersController < ApplicationController
    before_action :authenticate_user!
   

    before_action :get_offer, only: [:edit, :show,:update ]
    before_action :get_project, only: [:new,:offers_list,:create,:update]
    before_action :get_offers , only:[ :index]
    before_action :get_offers_list, only: [:offers_list]

     # To check if the user creating or viewing the offers is the owner of the offer
     before_action :authorize_user_sender,only: [:new]
    
     #To check if the user is the one who has the project; the custome receiving the offer
     before_action :authorize_user_reciever, only: [:offers_list,:update]
    def index
      # @offers = Offer.includes(:user, :project)
    
    
    end
    def show
      
    end
    def new

        @offer = Offer.new()

    end
    def edit
     
    end
    def update
      @offer.update_attribute(:accept,true)
      if @offer.save 
        flash[:notice] = "Project successfully updated"
        redirect_to @offer
      else
        flash[:alert] = "Something went wrong"
        render "edit", notice: "Something went wrong"
      end 
    end
    # to list all offers of a certain project
    def offers_list
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
        p "offer from get offer"
        p @offer
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
    def get_offers_list
      @offers_list = Offer.where(project_id: params[:project_id])
    end
    def authorize_user_sender
      if @project.user_id == current_user.id
        flash[:alert] = "You don't have permission"
        redirect_to projects_path
      end 
    end
    def authorize_user_reciever
      if @project.user_id != current_user.id
        flash[:alert] = "You don't have permission to see all the offers"
        redirect_to projects_path
      end 
    end
end
