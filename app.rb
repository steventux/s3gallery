require 'sinatra'
require 'aws/s3'
require 'json'

before do
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['S3_KEY'], 
    :secret_access_key => ENV['S3_SECRET'])
end

get '/' do
  "<h1>S3 Gallery</h1>"  
end

get '/:bucket' do
  begin
    @bucket = AWS::S3::Bucket.find(params[:bucket])
  rescue AWS::S3::AccessDenied => e
    puts e.message
  end
  erb :index
end
