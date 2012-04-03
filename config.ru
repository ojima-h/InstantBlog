require './application'

use Rack::CommonLogger

map '/' do
  run Application.new
end
