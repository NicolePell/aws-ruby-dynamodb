require "aws-sdk-core"
require "json"

Aws.config.update({
  region: "eu-west-1"
})

dynamodb = Aws::DynamoDB::Client.new

tableName = 'users'

file = File.read('users.json')
users = JSON.parse(file)
users.each{|user|
  params = {
    table_name: tableName,
    item: user
  }

  begin
    result = dynamodb.put_item(params)
    puts "Added user: #{user["user_id"]} #{user["email_address"]}"

  rescue Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to add user:"
    puts "#{error.message}"
  end
}
