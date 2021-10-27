class PetApplicationsController < ApplicationController
  def create
    application = Application.find(params[:id])
    application.pets << Pet.find(params[:pet_id])
    redirect_to "/applications/#{params[:id]}"
  end
end