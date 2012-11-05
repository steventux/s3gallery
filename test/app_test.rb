begin 
  require_relative 'test_helper'
rescue NameError
  require File.expand_path('test_helper', __FILE__)
end


describe "s3gallery app" do
  describe "GET to /" do
    before do
      get '/'
    end
    it "should redirect to index.html" do
      assert_equal 302, last_response.status
    end
  end
  describe "GET to /:bucket/:folder" do
    before do
      get '/my-pictures/animals'
    end
    it "should return images as JSON" do
      assert_equal '/picture/of/a/cat.jpg', JSON.parse(last_response.body).first
    end
    it "should only return certain file types" do
      urls = JSON.parse(last_response.body)
      refute_includes urls, '/some/random/folder'
      refute_includes urls, '/picture/of/fairies.bmp'
    end
  end
end
