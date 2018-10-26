class PaymentMethodsController < ApplicationController
	
	def new
			@payment = PaymentMethod.find(current_user.id) if @payment
			@payment = PaymentMethod.new
			
	end
	
	def create
	end
end