require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "should render home page" do
    get root_url 
    assert_template 'static_pages/home'
  end

end
