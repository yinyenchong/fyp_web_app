require 'test_helper'

class ComplaintRepliesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @complaint_reply = complaint_replies(:one)
  end

  test "should get index" do
    get complaint_replies_url
    assert_response :success
  end

  test "should get new" do
    get new_complaint_reply_url
    assert_response :success
  end

  test "should create complaint_reply" do
    assert_difference('ComplaintReply.count') do
      post complaint_replies_url, params: { complaint_reply: { reply: @complaint_reply.reply } }
    end

    assert_redirected_to complaint_reply_url(ComplaintReply.last)
  end

  test "should show complaint_reply" do
    get complaint_reply_url(@complaint_reply)
    assert_response :success
  end

  test "should get edit" do
    get edit_complaint_reply_url(@complaint_reply)
    assert_response :success
  end

  test "should update complaint_reply" do
    patch complaint_reply_url(@complaint_reply), params: { complaint_reply: { reply: @complaint_reply.reply } }
    assert_redirected_to complaint_reply_url(@complaint_reply)
  end

  test "should destroy complaint_reply" do
    assert_difference('ComplaintReply.count', -1) do
      delete complaint_reply_url(@complaint_reply)
    end

    assert_redirected_to complaint_replies_url
  end
end
