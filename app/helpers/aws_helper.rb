module AwsHelper
  def s3_signed_url(file, bucket = nil)
    s3 = AWS::S3.new
    bucket ||= Config[:aws][:bucket]
    bucket = s3.buckets[bucket]
    file = bucket.objects[file]
    file.url_for :read,
      endpoint: 's3.amazonaws.com',
      expires: 10.minutes.from_now,
      secure: true
  end
end
