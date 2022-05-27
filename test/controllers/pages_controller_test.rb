require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @admin_user = User.create(username: "Clark Kent", email: "clark@krypton.com",
                              password: "password123", admin: true)
                              
  end
  
  test "should show Categories on the nav bar" do
    get root_path
    assert_select "li.nav-item.dropdown", /Categories/
  end
  
  test "should show View Categories on dropdown to all users" do
    get root_path
    assert_select "a[href=?]", categories_path, text: "Show All"
  end
  
  test "should show Create Category on dropdown to admin users only" do
    sign_in_as(@admin_user)
    get articles_path
    assert_select "a[href=?]", new_category_path, text: "Create New"
  end
  
  test "should not show Create Category dropdown to non-users" do
    #sign_in_as(@admin_user)
    get articles_path
    assert_select "a[href=?]", new_category_path, false
  end
  
end
