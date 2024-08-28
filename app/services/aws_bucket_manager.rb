require "aws-sdk-s3"

# Wraps the getting started scenario actions.
class AwsBucketManager
  attr_reader :s3

  # @param s3_resource [Aws::S3::Resource] An Amazon S3 resource.
  def initialize
    @s3 = Aws::S3::Resource.new(
      region: ENV["AWS_REGION"],
      secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
      access_key_id: ENV["AWS_ACCESS_KEY_I"])
  end

  def bucket
    s3.bucket "services-management"
  end

  # Uploads a file to an Amazon S3 bucket.
  #
  # @param bucket [Aws::S3::Bucket] The bucket object representing the upload destination
  # @return [Aws::S3::Object] The Amazon S3 object that contains the uploaded file.
  def upload_file(filename, filepath)
    s3_object = bucket.object(File.basename(filename))
    s3_object.upload_file(filepath)
    s3_object
  rescue Aws::Errors::ServiceError => e
    puts("Couldn't upload file demo.txt to #{bucket.name}.")
    puts("\t#{e.code}: #{e.message}")
    raise
  end

  # Downloads an Amazon S3 object to a file.
  #
  # @param s3_object [Aws::S3::Object] The object to download.
  def download_file(filename)
    s3_object = bucket.object(File.basename(filename))
    s3_object.download_file(filename)
  rescue Aws::Errors::ServiceError => e
    raise
  end

  # Lists the objects in an Amazon S3 bucket.
  #
  # @param bucket [Aws::S3::Bucket] The bucket to query.
  def list_objects(bucket)
    puts("\nYour bucket contains the following objects:")
    bucket.objects.each do |obj|
      puts("\t#{obj.key}")
    end
  rescue Aws::Errors::ServiceError => e
    puts("Couldn't list the objects in bucket #{bucket.name}.")
    puts("\t#{e.code}: #{e.message}")
    raise
  end
end

# Runs the Amazon S3 getting started scenario.
def run_scenario(scenario)
  puts("-" * 88)
  puts("Welcome to the Amazon S3 getting started demo!")
  puts("-" * 88)

  bucket = scenario.create_bucket
  s3_object = scenario.upload_file(bucket)
  scenario.download_file(s3_object)
  scenario.copy_object(s3_object)
  scenario.list_objects(bucket)
  scenario.delete_bucket(bucket)

  puts("Thanks for watching!")
  puts("-" * 88)
rescue Aws::Errors::ServiceError
  puts("Something went wrong with the demo!")
end

run_scenario(ScenarioGettingStarted.new(Aws::S3::Resource.new)) if $PROGRAM_NAME == __FILE__
