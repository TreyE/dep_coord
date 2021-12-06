class ProjectsController < ApplicationController
  def index
    @projects = DependencyProjectRecord.all
  end
end