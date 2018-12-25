class Api::V1::ProjectsController < Api::V1::ApiController
  skip_before_action :require_login, only: [:show], raise: false

  def create
    project = Project.new(project_params)
    project.user = current_user

    if project.save
      UserMailer.new_project_created(project, @current_user).deliver

      render json: project
    else
      render_unauthorized("Error with your login or password")
    end
  end

  def show
    project = Project.find(params[:id])

    if project
      render json: project
    else
      render_unauthorized("You are not authorized.")
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :bio, :started_on)
  end
end
