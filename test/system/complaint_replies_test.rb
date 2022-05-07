require "application_system_test_case"

class ComplaintRepliesTest < ApplicationSystemTestCase
  setup do
    @complaint_reply = complaint_replies(:one)
  end

  test "visiting the index" do
    visit complaint_replies_url
    assert_selector "h1", text: "Complaint Replies"
  end

  test "creating a Complaint reply" do
    visit complaint_replies_url
    click_on "New Complaint Reply"

    fill_in "Reply", with: @complaint_reply.reply
    click_on "Create Complaint reply"

    assert_text "Complaint reply was successfully created"
    click_on "Back"
  end

  test "updating a Complaint reply" do
    visit complaint_replies_url
    click_on "Edit", match: :first

    fill_in "Reply", with: @complaint_reply.reply
    click_on "Update Complaint reply"

    assert_text "Complaint reply was successfully updated"
    click_on "Back"
  end

  test "destroying a Complaint reply" do
    visit complaint_replies_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Complaint reply was successfully destroyed"
  end
end
