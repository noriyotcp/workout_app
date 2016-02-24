class DashboardController < ApplicationController
  def index
    @members = User.all
  end
end
