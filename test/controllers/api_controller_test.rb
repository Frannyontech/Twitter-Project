require 'test_helper'

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_create_url
    assert_response :success
  end

end
