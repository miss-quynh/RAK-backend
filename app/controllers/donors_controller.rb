class DonorsController < ApplicationController

  def create
    @donor = Donor.new(donor_params)
    if @donor.save
      render json: @donor
    else
      @errors = @donor.errors.full_messages
      render json: {errors: @errors}, status: 406
    end
  end

  def show
    @donor = Donor.find(params[:id])
    @followings = @donor.followings
    render json: {donor: @donor, followings: @followings}
  end

  def update
    @donor = Donor.find(params[:id])
    @donor.update(donor_params)
    render json: @donor
  end

  def delete
    @donor = Donor.find(params[:id])
    @donor.destroy
    render status: 200
  end

  def filter
    filter = params["filters"]

    @projects = Project.all
    @projects = Project.projects_by_event(@projects, filter["events"])
    @projects = Project.projects_by_category(@projects, filter["categories"])
    @projects = Project.projects_by_type(@projects, filter["donationType"])

    @organizations = Project.organizations_by_projects(@projects)

    render json: {projects: @projects, organizations:@organizations}
  end

  def filter_options
    @filters = {}
    @filters[:categories] = []
    @filters[:donation_type] = []
    @filters[:events] = []

    Category.all.each do |category|
      @filters[:categories] << category.category_name
    end
    DonationType.all.each do |dontype|
      @filters[:donation_type] << dontype.type_name
    end
    Event.order(created_at: :desc).limit(20).each do |event|
      @filters[:events] << event.event_name
    end

    render json: @filters
  end

  private

  def donor_params
    params.require(:donor).permit(:first_name, :last_name, :email, :street_address, :city, :state, :zip_code, :password)
  end

end