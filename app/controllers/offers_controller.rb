class OffersController < ApplicationController
    #this before action allows user only to access the features of the app
    before_action :authenticate_user!
    
    before_action :get_offer, only: [:edit, :show,:update,:freelancer_show ]
    before_action :get_project, only: [:new,:offers_list,:create,:update,:edit]
    before_action :get_offers , only:[ :index]
    before_action :get_offers_list, only: [:offers_list]
    # To check if the user creating or viewing the offers is the owner of the offer
    before_action :authorize_user_sender,only: [:new,:create]
    #To check if the user is the one who has the project; the custome receiving the offer
    before_action :authorize_user_reciever, only: [:offers_list,:update,:show,:index]
    def index
      # @offers = Offer.includes(:user, :project)
    end
    def show
      
    end

    def new
      #to create a new offer
      @offer = Offer.new()
    end

    def edit
     
    end
    def update
      # Change the value of accept in offer to be true 
      # Change the value of freelanceruser_id to the user id of the one providing the offer that has been accepted
      @offer.update_attribute(:accept,true)
      @project.update_attribute(:freelanceruser_id, @offer.user_id)

      if @offer.save && @project.save
        flash[:notice] = "offer successfully updated"
        redirect_to @offer
      else
        flash[:alert] = "Something went wrong"
        render "edit", notice: "Something went wrong"
      end 
        
    end
    # to list all offers of a certain project
    def offers_list
    end
    def freelancer_show
    end
    def create 
        #create a new offer entry in Offer table with the parameters from the form
        @offer = @project.offers.new(offer_params)
        @offer.user_id =  current_user.id
        if @offer.save 
          redirect_to project_offers_path, notice: "offer successfully created"
        else
         
          render "new", notice: "Something went wrong"
        end 
    end 

    def authorize_user 
        #To check if the user doing the action is a freelancer not the user created the job
        if @project.user_id != current_user.id
          flash[:alert] = "You don't have permission to do that"
          redirect_to projects_path
        end 
    end 
   
    def get_offer
        #to get a certain offer from the table Offers with id from the params
        @offer = Offer.find(params[:id])
        p "offer from get offer"
        p @offer
    end

    def offer_params
        params.require(:offer).permit(:message, :accept)
    end
    def get_project
      # get a project from table Project
      @project = Project.find(params[:project_id])
     end

     def get_offers
      # get list of offers submited by the user who is loged in
      @offers = current_user.offers.all
    end
    def get_offers_list
      # get list of offers for a certain project 
      @offers_list = Offer.where(project_id: params[:project_id])
    end
    def authorize_user_sender
      if @offer.user_id == current_user.id
        flash[:alert] = "You don't have permission"
        redirect_to projects_path
      end 
    end
    def authorize_user_reciever
      @project = Project.find(params[:id])
      if @offer.project.user_id != current_user.id
        flash[:alert] = "You don't have permission to see all the offers"
        redirect_to projects_path
      end 
    end
end
