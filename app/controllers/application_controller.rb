class ApplicationController < ActionController::API
  def authenticate_user
    @user = User.find_by_token!(params[:token])
  end

  def ensure_hackathon_status(statuses)
    @hackathon ||= Hackathon.find(params[:hackathon_id])
    @hackathon.refresh_real_status
    render("hackathon status error", status: 401) unless statuses.include?(@hackathon.status)
  end
end
