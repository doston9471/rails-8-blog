require "application_system_test_case"

class PostsTest < ApplicationSystemTestCase
  setup do
    @post = posts(:one)
    @user = users(:one)
  end

  def sign_in
    visit new_session_url
    assert_selector "h1", text: "Sign in"
    fill_in "Email address", with: @user.email_address
    fill_in "Password", with: "secret"
    click_on "Sign in"
    # Wait for successful sign in and redirect
    assert_no_selector "h1", text: "Sign in"
  end

  test "visiting the index" do
    sign_in
    visit posts_url
    assert_selector "h1", text: "Posts"
  end

  test "should create post" do
    sign_in
    visit posts_url
    assert_selector "h1", text: "Posts"
    click_on "New post"
    assert_selector "h1", text: "New post"

    within("form") do
      fill_in "post[title]", with: @post.title
      # Clear and fill Trix editor
      find("trix-editor").click
      find("trix-editor").send_keys([ %i[meta backspace], @post.content ].flatten)
      click_button "Create Post"
    end

    assert_text "Post was successfully created"
  end

  test "should update Post" do
    sign_in
    visit post_url(@post)
    assert_selector "h1", text: "Showing post"
    click_on "Edit this post"
    assert_selector "h1", text: "Editing post"

    within("form") do
      fill_in "post[title]", with: @post.title
      # Clear and fill Trix editor
      find("trix-editor").click
      find("trix-editor").send_keys([ %i[meta backspace], @post.content ].flatten)
      click_button "Update Post"
    end

    assert_text "Post was successfully updated"
  end

  test "should destroy Post" do
    sign_in
    visit post_url(@post)
    assert_selector "h1", text: "Showing post"

    accept_confirm do
      click_button "Destroy this post"
    end

    assert_text "Post was successfully destroyed"
  end
end
