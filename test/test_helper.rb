# test_helper.rb
ENV['RACK_ENV'] = 'test'
require 'minitest/autorun'
require 'rack/test'
require 'json'

begin
  require_relative '../app'
rescue NameError 
  require File.expand_path('../app', __FILE__)
end

include Rack::Test::Methods
def app() Sinatra::Application end

module AWS
  module S3
    class Base
      def self.establish_connection!(opts)
        true
      end
    end
    class Bucket
      def self.objects(name, opts)
        ['/picture/of/a/cat.jpg','/some/random/folder',
         '/picture/of/a/dog.png','/picture/of/fairies.bmp'].map do |url|
            AWS::MockS3Object.new(url)
        end
      end
    end
  end
  class MockS3Object
    attr_reader :url
    def initialize(url)
      @url = url
    end
  end
end
