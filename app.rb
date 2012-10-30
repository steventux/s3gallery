require 'sinatra'
require 'sinatra/json'
require 'aws/s3'

before do
  AWS::S3::Base.establish_connection!(
    :access_key_id     => ENV['S3_KEY'], 
    :secret_access_key => ENV['S3_SECRET'])
end

helpers do
  def image_objects(bucket, folder)
    s3objects = AWS::S3::Bucket.objects(params[:bucket], prefix: params[:folder])
  
    s3objects.map(&:url).select! { |url|
      # TODO: Revisit this. 
      url =~ /\w+\.(gif|jpg|jpeg|png)/ 
    }
  end
end

get '/' do
  redirect "/index.html"  
end

get '/:bucket/:folder' do
  json image_objects(params[:bucket], params[:folder]) 
end

get '/galleryjs/:bucket/:folder/:element_id' do
  @urls = json image_objects(params[:bucket], params[:folder])
  erb "s3gallery.js".to_sym
end
