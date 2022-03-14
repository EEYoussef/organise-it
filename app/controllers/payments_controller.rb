class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]
  def success
    @project = Project.find(params[:id])
    #@listing.sold = true 
  end

  def webhook 
   payment_intent_id = params[:data][:object][:payment_intent]
   payment = Stripe::PaymentIntent.retrieve(payment_intent_id)
   project_id = payment.metadata.project_id 
   pp payment.charges.data[0].receipt_url
   @project.update(receipt_url: payment.charges.data[0].receipt_url )
   @project = Project.find(project_id)
   @project.update(sold: true)
  end
end
