s3gallery
=========

Image gallery service you can add to any app!

Get Started!
------------

export vars S3_KEY and S3_SECRET with your S3 credentials.

$ ruby -rubygems app.rb

Visit http://localhost:4567/index.html for a demo (expects a bucket named 's3gallery' and images in a folder named 'gallery1').

You need jquery included in the page calling the gallery, then add the following script tag:

&lt;script src="http://localhost:4567/galleryjs/bucketname/foldername/element_id"&gt;&lt;/script&gt;

This script targets the dom element specified in the 'element_id' portion of the script src and appends your gallery items after it.

TODO
----

 - Pass gallery height and width via params.
 - HTML video...?
