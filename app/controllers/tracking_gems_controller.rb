class TrackingGemsController < ApplicationController
  def create
    unread_gem = UnreadGem.find(params[:unread_gem_id])
    tracking_gem = TrackingGem.new(name: unread_gem.name, latest_version: unread_gem.version)
    tracking_gem.save!

    redirect_to unread_gems_path
  end
end
