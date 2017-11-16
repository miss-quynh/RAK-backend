class OrganizationsController < ApplicationController

  def index
    @organizations = Organization.all.order(:id)

    render json: @organizations
  end

  def show
    @organization = Organization.find_by(id: params[:id])
    @projects = @organization.projects

    render json: {organization: @organization, projects: @projects, category: @organization.category}
  end

  def new
    @organization = Organization.new
  end

  def ein
    p ein = params['ein']
    ein = GuidestarSearchAdapter.verify_organization(ein)
    json:
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      render json: {organization: @organization, image_url: @organization.avatar.url}
    else
      render json: {errors: @organization.errors.full_messages}, status: 422
    end

  end

  def edit
    @organization = Organization.find_by(id: params[:id])

    render json: @organization
  end

  def update
    @organization = Organization.find_by(id: params[:id])

    if @organization.update(organization_params)
      render json: @organization
    else
      render json: {errors: @organizations.errors.full_messages}, status: 406
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:organization_name, :tax_code, :email, :password, :password_confirmation, :avatar, :category_id)
  end

end
