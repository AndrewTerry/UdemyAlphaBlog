require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  
  setup do
   @admin_user = User.create(username: "Clark Kent", email: "clark@krypton.com",
                             password: "password123", admin: true)
  end
  
  test "get new category form" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_select "h1", "New Category"
  
    assert_difference 'Category.count', 1 do
      post "/categories", params: { category: {name: "Sports"} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end
  
  test "get new category form and create invalid category" do
    sign_in_as(@admin_user)
    get "/categories/new"
    assert_select "h1", "New Category"
  
    assert_no_difference 'Category.count' do
      post "/categories", params: { category: {name: " "} }
    end
    assert_match "errors", response.body
  end
  
end
