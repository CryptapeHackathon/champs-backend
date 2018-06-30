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
    @hackathon = Hackathon.new(hackathon_params[:hackathon])

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
