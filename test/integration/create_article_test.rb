require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
   @user = User.create(username: "Clark Kent", email: "clark@krypton.com",
                             password: "password123")
    
  end
  
  test "should not show new article form unless logged in" do
    get "/articles/new"
    assert_redirected_to login_path
  end

  test "should create article" do
    sign_in_as(@user)
    
    assert_difference 'Article.count', 1 do
      post "/articles", params: { article: {title: "Clark's Article",
        description: "My planet is gone... Or is it??"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "planet", response.body
  end

end
