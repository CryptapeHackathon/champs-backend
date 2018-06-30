class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :update, :destroy, :vote_cli]
  before_action :authenticate_user, only: [:create]
  before_action :check_create_permission, only: [:create]
  before_action :check_update_permission, only: [:update]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  def vote_cli
    function = "vote"
    args = [@team.user.address]
    h = HacksContract::Hackathon.new(@team.hackathon.address)
    command = h.rpc(function, args, invoke: false, transaction: true)
    render json: {command: command}
  end

  def votes
    h = HacksContract::Hackathon.new(@team.hackathon.address)
    votes = h.votes(@team.user.address)
    render json: {votes: votes}
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # POST /teams
  # POST /teams.json
  def create
    # 验证是否在合约中注册？
    # 没有注册则报错
    @team = Team.find_or_initialize_by(team_params.slice(:hackathon_id).merge(user_id: @user))
    @team.attributes = team_params
    if @team.save
      render :show, status: :created, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    if @team.update(team_params.slice(:introduction))
      render :show, status: :ok, location: @team
    else
      render json: @team.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
  end

  private

  def check_update_permission
    ensure_hackathon_status([:gaming])
  end

  def check_create_permission
    @hackathon ||= Hackathon.find(params[:hackathon_id])
    if @hackathon.teams.count >= @hackathon.teams_count
      render json: {error: "participate teams reach limit"}, status: :bad_request
      return
    end
    ensure_hackathon_status([:apply_participation])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_team
    @team = Team.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def team_params
    params.require(:team).permit(:hackathon_id, :name, :introduction)
  end
end
