class PagesController < ApplicationController
    before_action :authenticate_user!, only:[:restricted, :profile]
    skip_before_action :verify_authenticity_token
    def restricted
    end
    
    
    def profile
    end
    def update_profile
        render plain: "this is update profile"
    end
end
