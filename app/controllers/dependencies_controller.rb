class DependenciesController < ApplicationController
  def index
    @dependencies = DependencySourceRecord.all
  end
end