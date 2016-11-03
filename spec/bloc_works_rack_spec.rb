require_relative '../lib/bloc_works.rb'
require 'test/unit'
require 'rack/test'


class BlocWorksTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    BlocWorks::Application.new
  end

  end

  def test_it_receives_200_status
    get "/"

    assert last_response.ok?
    assert_equal(200, last_response.status)
  end

  def test_it_sends_text_html_content
    get "/"

    assert_equal("text/html", last_response.content_type)
  end

  def test_it_displays_text
    get "/"
    assert_equal("Hello Blocheads!", last_response.body)
  end
end

class BlocWorksRouterTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    BlocWorks::Application.new
  end

  def test_it_routes_http_to_controller_and_action
    # tests controller_and_action
    # after receiving HTTP path via env variable
    # should return first part of path as Controller
    # second as action
  end

  def test_it_routes_http_to_fav_icon
    # tests fav_icon
    # after receiving HTTP path
    # should return 404 code and blank page for now
  end
end
