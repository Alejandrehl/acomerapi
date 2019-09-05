class FeaturedBranchController < ApplicationController
  def index
    @branch = Branch.all
    @featuredbranches = FeaturedBranch.all
  end

  def featuredbranch
    @featuredbranch = FeaturedBranch.new()
    @featuredbranch.branch_id = params[:branch_id]
    @featuredbranch.description = params[:description]
    @featuredbranch.save
  end

end
