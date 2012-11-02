begin 
  require_relative 'test_helper'
rescue NameError
  require File.expand_path('test_helper', __FILE__)
end

require 'minitest/benchmark'

include Rack::Test::Methods
def app() Sinatra::Application end

describe "s3gallery app" do
  bench_range { bench_exp 1, 10_000 } 
  bench_performance_linear "welcome message", 0.9999 do |n|
    n.times do
      get '/'
      assert_equal 'Welcome to my page!', last_response.body 
    end 
  end
end
