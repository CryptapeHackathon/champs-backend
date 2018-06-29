class ApplicationController < ActionController::API

  # before_action :disable_cors

  def authenticate_user
    @user = User.find_by_token!(params[:token])
  end

  def ensure_hackathon_status(statuses)
    @hackathon ||= Hackathon.find(params[:hackathon_id])
    @hackathon.refresh_real_status
    render("hackathon status error", status: 401) unless statuses.include?(@hackathon.status)
  end

  # def disable_cors
  #   headers['Access-Control-Allow-Origin'] = '*'
  #   headers['Access-Control-Allow-Methods'] = 'POST, PUT, DELETE, GET, OPTIONS'
  #   headers['Access-Control-Request-Method'] = '*'
  #   headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Accept-Encoding, Accept-Language, Authorization, Connection, Host, User-Agent, Access-Control-Request-Headers, Access-Control-Request-Method'
  # end
end
