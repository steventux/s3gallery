require 'sinatra'
require 'sinatra/json'
require 'aws/s3'

before do
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['S3_KEY'], 
    :secret_access_key => ENV['S3_SECRET'])
end

get '/' do
  "GET /:bucket/:folder"  
end

get '/:bucket/:folder' do
  s3objects = AWS::S3::Bucket.objects(params[:bucket], prefix: params[:folder])
  
  json s3objects.map(&:url).select! { |url|
    url =~ /\w+\.(gif|jpg|jpeg|png)/ # TODO: Handle other media
  }
end
