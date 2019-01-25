class Pafs::Projects::ApiV1 < Grape::API
  format :json

  helpers do
    def project_presenter(project)
      Entities::Pafs::V1::Project.present(project)
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    error! "Project not found", 404
  end

  resource :projects do
    desc "Return a single project"
    params do
      requires :slug, type: String, desc: "Reference Number of a project"
    end
    route_param :slug do
      get do
        project = PafsCore::Project.find_by_slug(params[:slug])

        raise ActiveRecord::RecordNotFound unless project

        project_presenter(project)
      end
    end
  end
end
