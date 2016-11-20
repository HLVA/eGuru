require 'test_helper'

class GeneralControllerTest < ActionDispatch::IntegrationTest
  test "should get aboutus" do
    get general_aboutus_url
    assert_response :success
  end

end
