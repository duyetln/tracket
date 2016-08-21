require 'services/base'

module Services
  class Projects < Base
    get '/' do
      projects = paginate(Project)
      respond_with(projects.map do |project|
        ProjectSerializer.new(project)
      end)
    end

    get '/:id' do
      project = Project.find(id)
      respond_with(ProjectSerializer.new(project))
    end

    get '/:id/issues' do
      project = Project.find(id)
      issues = paginate(project.issues)
      respond_with(issues.map do |issue|
        IssueSerializer.new(issue)
      end)
    end

    post '/' do
      project = Project.new(params['project'].slice('name', 'description'))
      params['project']['fields'].each do |field|
        initialize_field(project, field)
      end
      project.save!
      respond_with(ProjectSerializer.new(project))
    end

    post '/:id/fields' do
      project = Project.find(id)
      field = initialize_field(project, params['field'])
      field.save!
      respond_with(FieldSerializer.new(field))
    end

    post '/:id/rules' do
    end

    post '/:id/issues' do
    end

    protected

    def initialize_field(project, field_params)
      project.fields.new(field_params.slice('name', 'type')).tap do |field|
        if field.is_a? OptionField
          field_params['options'].each do |option|
            field.options.new(option.slice('name'))
          end
        end
      end
    end
  end
end
