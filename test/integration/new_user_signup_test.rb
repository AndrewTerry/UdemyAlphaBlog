require "test_helper"

class NewUserSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  test "get new user signup form" do
    get '/signup'
    assert_response :success
  end
  
  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { username: "Clark Kent",
      email: "clark@krypton.com", password: "password123" } }
    end
  
    assert_redirected_to login_path
end

  
  
end
