require File.expand_path '../test_helper.rb', __FILE__

class MyTest < Minitest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_hello_world
    get '/'
    assert last_response.ok?
    assert_equal "Hello, World!", last_response.body
  end

  def test_get_with_params
    get '/1'
    assert last_response.ok?
    assert_equal "Hello 1!", last_response.body
  end
end
