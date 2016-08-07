class UnreadGemsController < ApplicationController
  before_action :load_resource

  def index
  end

  def load_resource
    @unread_gems = UnreadGem.all
  end
end
