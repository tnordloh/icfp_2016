require 'rest-client'
require 'json'
require 'date'

class ProblemAPI 

  API_KEY='62-08715aadce013af728b067ea4684dd29'
  SNAPSHOT_LIST='http://2016sv.icfpcontest.org/api/snapshot/list'
  BLOB='http://2016sv.icfpcontest.org/api/blob/'
  SUBMIT='http://2016sv.icfpcontest.org/api/solution/submit'

  test_url='http://2016sv.icfpcontest.org/api/hello'
  base_url='http://2016sv.icfpcontest.org/api'
  test = 'hello'

#  response = RestClient.get(
#    list_url,
#    :content_type => :json,
#    :accept_type => :json,
#    :'X-API-key' => API_KEY
#
#  )
#  puts
#  h = JSON.parse(response)
#  p h

  def get_something(url)
    sleep 1
    p url
    RestClient.get(
      url,
      :'X-API-key' => API_KEY
    )
  end

  def snapshot
    @snapshots ||= latest_snapshot
  end

  def latest_snapshot
    response = get_something(SNAPSHOT_LIST)
    snaps = JSON.parse(response)
    latest = snaps["snapshots"].max_by {|snap| snap["snapshot_time"]}
    JSON.parse(get_something(BLOB+latest["snapshot_hash"]))
  end

  def problems
    response = snapshot["problems"]
  end

  def problem_spec(hash)
    get_something(BLOB+hash).to_s
  end

  def submit_solution(file)
    sleep 1
    p SUBMIT
    x = RestClient.post(
      SUBMIT,
      {:problem_id => 1,
       :solution_spec => File.read(file)
      },
      :'X-API-key' => API_KEY
    )
    p JSON.parse(x)
  end
  
  def next_hour
    t = Time.new + (60 * 60)
    Time.new(t.year,t.month,t.day,t.hour).to_i
  end

end


