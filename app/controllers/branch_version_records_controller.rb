class BranchVersionRecordsController < ApplicationController
  def show
    @branch_version_record = BranchVersionRecord.find(params[:id])
  end
end