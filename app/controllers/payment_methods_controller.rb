class PaymentMethodsController < ApplicationController
	
	def new
			user = current_user
			@payment = PaymentMethod.find(user.id) if @payment
			@payment = PaymentMethod.new
			
	end
	
	def create
	end
end