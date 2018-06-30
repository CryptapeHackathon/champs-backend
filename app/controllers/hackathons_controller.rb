class HackathonsController < ApplicationController
  before_action :set_hackathon, only: [:show, :update, :destroy, :apply_cli, :funding_cli]
  before_action :check_update_permission, only: [:update]

  # GET /hackathons
  # GET /hackathons.json
  def index
    @hackathons = Hackathon.all
  end

  def create_cli
    args = params[:args]
    command = HacksContract::HackathonFactory.new.create_hackathon(*args, invoke: false)
    render json: {command: command}
  end

  def encode
    contract = params[:contract]
    abi = if contract == 'hackathon'
            HacksContract::Hackathon::ABI_CONTENT
          else
            HacksContract::HackathonFactory::ABI_CONTENT
          end
    function = params[:function]
    args = params[:args]
    data = HacksContract.encode_function(abi, function, *args)
    render json: {data: data}
  end

  def cli
    function = params[:function]
    args = params[:args]
    h = HacksContract::Hackathon.new(@hackathon.address)
    command = h.rpc(function, args, invoke: false, transaction: true)
    render json: {command: command}
  end

  # GET /hackathons/1
  # GET /hackathons/1.json
  def show
  end

  # POST /hackathons
  # POST /hackathons.json
  def create
    #{"function"=>"CreateHackathon", "args"=>[20, 172800000, 172800000, 172800000, 172800000, 200, 200, 20, 20, 20, 40, 23, 23], "contract"=>"hackathonFactory", "hackathon"=>{}}
    # :topic, :host_fund_eth, :target_fund_eth, :teams_count, :participation_fee_eth, :award_eth_list, :vote_reward_percent, :crow_funding_start_at, :apply_start_at, :game_start_at, :vote_start_at, :finished_at, :status
    # (fund_target, fund_period, sign_up_period, match_period, vote_period, deposit, sign_up_fee, champ_bonus, second_bonus, thrid_bonus, vote_bonus, max_teams, min_teams, invoke: true)
    params.permit!
    hackathon_params = params.slice(:name, :host_introduction, :address)
    args = params[:contract]
    now = Time.now
    hackathon_params[:crow_funding_start_at] = now
    hackathon_params[:target_fund_eth] = args[0]
    hackathon_params[:apply_start_at] = Time.at(now.to_i + (args[1] / 1000))
    hackathon_params[:game_start_at] = Time.at(now.to_i + (args[2] / 1000))
    hackathon_params[:vote_start_at] = Time.at(now.to_i + (args[3] / 1000))
    hackathon_params[:finished_at] = Time.at(now.to_i + (args[4] / 1000))
    hackathon_params[:participation_fee_eth] = args[6].to_eth
    hackathon_params[:award_eth_list] = args[7..9].map(&:to_eth)
    hackathon_params[:vote_reward_percent] = args[10]
    hackathon_params[:teams_count] = args[11]
    @hackathon = Hackathon.new(hackathon_params)

    if @hackathon.save
      render :show, status: :created, location: @hackathon
    else
      render json: @hackathon.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /hackathons/1
  # PATCH/PUT /hackathons/1.json
  def update
    if @hackathon.update(hackathon_params)
      render :show, status: :ok, location: @hackathon
    else
      render json: @hackathon.errors, status: :unprocessable_entity
    end
  end

  # DELETE /hackathons/1
  # DELETE /hackathons/1.json
  def destroy
    @hackathon.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_hackathon
    @hackathon = Hackathon.find(params[:id])
  end

  def check_update_permission
    ensure_hackathon_status([:gaming, :preparation])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def hackathon_params
    params.require(:hackathon).permit(:name, :host_introduction, :address, :topic, :host_fund_eth, :target_fund_eth, :teams_count, :participation_fee_eth, :award_eth_list, :vote_reward_percent, :crow_funding_start_at, :apply_start_at, :game_start_at, :vote_start_at, :finished_at, :status)
  end
end
