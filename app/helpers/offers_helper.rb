module OffersHelper
    def check_acceptance_is_false(project_id)
        project = Project.find(project_id)
       result= project.offers.where(accept:true) 
       if result.empty?
        return true
       else
        return false
       end
    end

end
