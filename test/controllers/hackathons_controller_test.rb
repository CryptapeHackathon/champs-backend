require 'test_helper'

class HackathonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @hackathon = hackathons(:one)
  end

  test "should get index" do
    get hackathons_url, as: :json
    assert_response :success
  end

  test "should create hackathon" do
    assert_difference('Hackathon.count') do
      post hackathons_url, params: { hackathon: { apply_start_at: @hackathon.apply_start_at, award_wei_list: @hackathon.award_wei_list, crow_funding_start_at: @hackathon.crow_funding_start_at, finished_at: @hackathon.finished_at, game_start_at: @hackathon.game_start_at, host_fund_wei: @hackathon.host_fund_wei, host_introduction: @hackathon.host_introduction, name: @hackathon.name, participation_fee_wei: @hackathon.participation_fee_wei, status: @hackathon.status, target_fund_wei: @hackathon.target_fund_wei, teams_count: @hackathon.teams_count, topic: @hackathon.topic, vote_reward_percent: @hackathon.vote_reward_percent, vote_start_at: @hackathon.vote_start_at } }, as: :json
    end

    assert_response 201
  end

  test "should show hackathon" do
    get hackathon_url(@hackathon), as: :json
    assert_response :success
  end

  test "should update hackathon" do
    patch hackathon_url(@hackathon), params: { hackathon: { apply_start_at: @hackathon.apply_start_at, award_wei_list: @hackathon.award_wei_list, crow_funding_start_at: @hackathon.crow_funding_start_at, finished_at: @hackathon.finished_at, game_start_at: @hackathon.game_start_at, host_fund_wei: @hackathon.host_fund_wei, host_introduction: @hackathon.host_introduction, name: @hackathon.name, participation_fee_wei: @hackathon.participation_fee_wei, status: @hackathon.status, target_fund_wei: @hackathon.target_fund_wei, teams_count: @hackathon.teams_count, topic: @hackathon.topic, vote_reward_percent: @hackathon.vote_reward_percent, vote_start_at: @hackathon.vote_start_at } }, as: :json
    assert_response 200
  end

  test "should destroy hackathon" do
    assert_difference('Hackathon.count', -1) do
      delete hackathon_url(@hackathon), as: :json
    end

    assert_response 204
  end
end
