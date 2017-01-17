require "aws-sdk-core"

Aws.config.update({
  region: "eu-west-1"
})

dynamodb = Aws::DynamoDB::Client.new

params = {
  table_name: "users",
  key_schema: [
    {
      attribute_name: "user_id",
      key_type: "HASH"
    }
  ],
  attribute_definitions: [
    {
      attribute_name: "user_id",
      attribute_type: "N"
    }
  ],
  provisioned_throughput: {
    read_capacity_units: 10,
    write_capacity_units: 10
  }
}

begin
  result = dynamodb.create_table(params)
  puts "Created tabled. Status: " + result.table_description.table_status;

rescue Aws::DynamoDB::Errors::ServiceError => error
  puts "Unable to create table:"
  puts "#{error.message}"
end
