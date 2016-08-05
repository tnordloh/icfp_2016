require File.expand_path '../test_helper.rb', __FILE__

class AppTest < Minitest::Unit::TestCase

  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_hello_world
    results = "26.txt89.txt91.txt90.txt25.txt1.txt77.txt39.txt18.txt48.txt60.txt93.txt79.txt53.txt19.txt76.txt22.txt85.txt98.txt51.txt31.txt74.txt61.txt14.txt9.txt13.txt81.txt55.txt64.txt65.txt10.txt46.txt35.txt29.txt16.txt41.txt84.txt6.txt94.txt70.txt50.txt..11.txt96.txt30.txt33.txt38.txt58.txt66.txt28.txt49.txt95.txt43.txt27.txt62.txt34.txt73.txt92.txt17.txt21.txt71.txt42.txt52.txt7.txt72.txt4.txt37.txt47.txt32.txt78.txt97.txt69.txt24.txt44.txt5.txt86.txt80.txt57.txt23.txt45.txt83.txt101.txt82.txt99.txt40.txt59.txt87.txt12.txt2.txt75.txt15.txt56.txt54.txt67.txt100.txt88.txt3.txt20.txt8.txt36.txt63.txt.68.txt"
    get '/'
    assert last_response.ok?
    assert_equal results, last_response.body
  end

  def test_get_with_params
    results = "{\"polygons\":[{\"negative\":false,\"vertices\":[\"0,0\",\"1,0\",\"1,1\",\"0,1\"]}],\"lines\":[[[\"0\",\"0\"],[\"1\",\"0\"]],[[\"0\",\"0\"],[\"0\",\"1\"]],[[\"1\",\"0\"],[\"1\",\"1\"]],[[\"0\",\"1\"],[\"1\",\"1\"]]]}"
    get '/1'
    assert last_response.ok?
    assert_equal results, last_response.body
  end
end
