class IgnoringGemsController < ApplicationController
  def create
    ignoring_gem = IgnoringGem.new(params.require(:ignoring_gem).permit(:name, :registered_version))

    ignoring_gem.save!

    redirect_to unread_gems_path
  end
end
