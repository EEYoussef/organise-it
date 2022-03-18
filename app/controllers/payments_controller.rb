class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  def success
    @payment = Payment.find_by(project_id: params[:id])
    #@listing.sold = true 
   
  end
  def create_payment_intent
  
    project = Project.find(params[:id])
    session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'], 
        customer_email: current_user&.email, #current_user && current_user.email 
        line_items: [{
          name: project.title, 
          description: project.description, 
          amount: project.price,
          currency: 'aud', 
          quantity: 1
        }], 
        payment_intent_data: {
          metadata: {
            user_id: current_user&.id,
            project_id: project.id
          }
        }, 
       success_url: "#{root_url}payments/success/#{project.id}",   
        cancel_url: "#{root_url}/projects"
      )
  
      @session_id = session.id 
      
     puts "*************session_id"
     pp @session_id
  end 
  def webhook 
    puts "********webhook"
  #  payment_intent_id = params[:data][:object][:payment_intent]
  #  payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
  #  project_id = payment.metadata.project_id 
  #  pp payment.charges.data[0].receipt_url
   
  #  @project = Project.find(project_id)
  #  @project.update(sold: true, receipt_url: payment.charges.data[0].receipt_url)
   
  begin 
    payload = request.raw_post
    sig_head = request.headers['HTTP_STRIPE_SIGNATURE']
    puts "********sig_head"
    puts sig_head
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_signing_secret)
    event = Stripe::Webhook.construct_event(payload, sig_head, endpoint_secret) 
   
    rescue JSON::ParserError => e 
      render json: {error: "Bad request"}, status: 422
      return 
    rescue Stripe::SignatureVerificationError => e 
       
      render json: {error: "Unauthorised"}, status: 403
      return
     
    end
    puts "**************"
    pp event
    puts "****************"
   payment_intent_id = event.data.object.payment_intent
   payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
   project_id = payment.metadata.project_id 
   user_id = payment.metadata.user_id
   
   project = Project.find(project_id)
   freelanceruser_id= project.freelanceruser_id
   project.update(sold: true)
   p payment.metadata.user_id
   p "------"
    p payment.metadata.project_id 
   Payment.create(project_id: project_id, user_id: user_id, freelanceruser_id: freelanceruser_id, payment_id: payment_intent_id, receipt_url: payment.charges.data[0].receipt_url)
  end 
  
end
