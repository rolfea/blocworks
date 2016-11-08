require_relative '../lib/bloc_works.rb'
require 'test/unit'
require 'rack/test'


# class BlocWorksTest < Test::Unit::TestCase
#   include Rack::Test::Methods
#
#   def app
#     BlocWorks::Application.new
#   end
#
#   def test_it_receives_200_status
#     get "/"
#
#     assert last_response.ok?
#     assert_equal(200, last_response.status)
#   end
#
#   def test_it_sends_text_html_content
#     get "/"
#
#     assert_equal("text/html", last_response.content_type)
#   end
#
#   def test_it_displays_text
#     get "/"
#     assert_equal("Hello Blocheads!", last_response.body)
#   end
# end

class BlocWorksRouterTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    BlocWorks::Application.new
  end

  def test_it_routes_http_to_controller_and_action
    get "/books/welcome"

    assert last_response.ok?
    assert_equal(200, last_response.status)
    assert_equal("text/html", last_response.content_type)
    assert_equal("Hello Blocheads!", last_response.body)
  end

  def test_it_routes_create
    get "/books/create"

    assert_equal(200, last_response.status)
    assert_equal("Create", last_response.body)
  end

  def test_it_routes_read
    get "/books/read"

    assert_equal(200, last_response.status)
    assert_equal("Read", last_response.body)
  end

  def test_it_routes_update
    get "/books/update"

    assert_equal(200, last_response.status)
    assert_equal("Update", last_response.body)
  end

  def test_it_routes_destroy
    get "/books/destroy"

    assert_equal(200, last_response.status)
    assert_equal("Destroy", last_response.body)
  end

  def test_it_routes_http_to_fav_icon
    get "/favicon.ico"

    assert_equal(404, last_response.status)
  end
end
