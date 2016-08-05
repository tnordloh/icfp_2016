require 'sinatra'

get '/' do
  'Hello world'
end

get '/:id' do
  "Hello #{params['id']}!"
end
