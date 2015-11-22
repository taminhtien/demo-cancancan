class ProjectsController < ApplicationController
  before_action :load_projects, only: :index
  load_and_authorize_resource
  
  # It composed of two method: load_resource and authorize_resource
  # load_resource is going to load the record
  # authorize_resource is going to check if the user is authorized to perform an action

  def create
    if @project.save
      flash[:success] = 'Project was saved!'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = 'Project was updated!'
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    if @project.destroy
      flash[:success] = 'Projet was destroyed!'
    else
      flash[:warning] = 'Cannot destroy this project!'
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :ongoing)
  end

  def load_projects

    # The idea is that load_resource will load a resource into the instance variable only if it hasn’t been set yet.
    # As long as I’ve added the before_action to set @projects, load_resource will not do anything for the index action.
    # It is important to place before_action before load_and_authorize_resource.

    @projects = Project.accessible_by(current_ability).order('created_at DESC')

    # Using accessible_by to load only the records that the current user has rights to access.
  end
end