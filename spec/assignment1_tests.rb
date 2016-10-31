require_relative '../lib/bloc_works.rb'
require 'test/unit'
require 'rack/test'


class BlocWorksTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    BlocWorks::Application.new
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
