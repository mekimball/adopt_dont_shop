class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @found_pets = Pet.adoptable.search_pets(params)
  end

  def new
    @application = Application.find_by(id: app_params[:application_id])
  end

  def index
    @application = Application.all
  end

  def create
    application = Application.new(app_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Error: #{error_message(application.errors)}"
      render :new
    end
  end

  def update
    @application = Application.find_by(id: params[:id])
    @application.status = params[:status]
    @application.good_home = params[:good_reason]
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  private

  def app_params
    params.permit(:name, :street, :city, :state, :zip_code, :good_home,
                  :status)
  end
end
