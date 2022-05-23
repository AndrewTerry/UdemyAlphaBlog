require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form" do
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
end
