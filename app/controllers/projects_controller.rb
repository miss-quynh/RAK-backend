class ProjectsController < ApplicationController
	# before_action :authenticate_organization, only: [:create, :update, :destroy]

	def index
		@projects = Project.all

		render json: @projects
	end

	#visible to signed all users
	def show
	  @project = Project.find_by(id: params[:id])

	  render json: {project: @project, donations: @project.project_donations }
	end

	#visible to signed-in organizations
	def new
		@project = Project.new

		render json: @project
	end

	def edit
		@project = Project.find_by(id: params[:id])

		render json: @project
	end

	def create
	  @project = Project.new(project_params)
		@organization = Organization.find_by(id: params[:organization_id])
		@event = Event.find_or_create_by(event_name: params[:event])
		@project.organization = @organization
		@project.event = @event

	  if @project.save
	  	render json: @project
	  else
	  	p @project.errors.full_messages
	  	@errors = @project.errors.full_messages
	  	render json: @errors, status: 406
	  end
	end

	def update
		@project = Project.find_by(id: params[:id])

		if @project.update(project_params)
			if project_params[:event] != @project.event.event_name
				@project.event = Event.find_or_create_by(event_name: project_params[:event])
			elsif !project_params[:event]
				@project.event = nil
			end
			render json: {project: @project, event: @project.event.event_name}
		else
			@errors = @project.errors.full_messages
	  	render json: @errors, status: 406
		end
	end

	def destroy
		@project = Project.find_by(id: params[:id])
		@project.destroy

		render status: 200
	end

	private

	def project_params
		params.require(:project).permit(:project_name, :street_address, :city, :state, :zip_code, :description)
	end

end
