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

  def ein
    ein = params['ein']
    @orgInfo = GuidestarSearchAdapter.verify_organization(ein)

    if @orgInfo
      render json: @orgInfo, status: 200
    else
      @errors = ["Invalid EIN"]
      render json: @errors, status: 422
    end
  end

  def create

    @organization = Organization.new(organization_params)
    @category = Category.find_by(category_name: params['category'])
    @organization.category = @category

    if @organization.save
      render json: {organization: @organization}
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

  def search
    @org = Organization.find_by_email(organization_params[:email])
    render json: @org
  end

  private

  def organization_params
    params.require(:organization).permit(:organization_name, :tax_code, :email, :password, :password_confirmation, :mission_statement, :avatar, :category_id)
  end

end
