require File.expand_path '../test_helper.rb', __FILE__

class AppTest < Minitest::Test

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
    (1..100).each do |num|
      assert_match(/#{num}/, last_response.body)
    end
  end

  def test_show_with_params
    get '/1'
    assert last_response.ok?
    assert_match(/negative/, last_response.body)
    assert_match(/vertices/, last_response.body)
    assert_match(/polygons/, last_response.body)
    assert_match(/lines/, last_response.body)
  end

  def test_additional_show_with_params
    get '/100'
    assert last_response.ok?
    assert_match(/negative/, last_response.body)
    assert_match(/vertices/, last_response.body)
    assert_match(/polygons/, last_response.body)
    assert_match(/lines/, last_response.body)
  end
end
