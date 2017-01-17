require "aws-sdk-core"

Aws.config.update({
  region: "eu-west-1"
})

dynamodb = Aws::DynamoDB::Client.new

tableName = 'users'

luiza_users = [66228, 12411, 23887, 5326, 14497, 89543, 27090, 2, 32505, 72999,
  40526, 85498, 53775, 66138, 65610, 85422, 61427, 96022]

zoe_users = [54908, 21056, 29650, 88512, 31036, 66478, 52875, 49133, 86646, 29607,
  61053, 33806, 20914, 67372, 3887, 41196, 67015, 60973, 56203, 32125, 42903,
  94196, 81871, 14125, 1, 25732, 1484321365284, 83721, 99207, 69557]

luiza_profile_picture_uri = "https://s3-eu-west-1.amazonaws.com/connectedstoreassets/user_images/App-LoggedInProfileLuiza.png"
zoe_profile_picture_uri = "https://s3-eu-west-1.amazonaws.com/connectedstoreassets/user_images/App-LoggedInProfileZoe.png"

luiza_users.each do |id|
  begin
    dynamodb.update_item({
      table_name: "users",
      key: {
        "user_id": id
      },
      update_expression: "SET profile_picture_uri = :profile_picture_uri",
      expression_attribute_values: {
        ':profile_picture_uri' => luiza_profile_picture_uri.gsub("connectedstoreassets", "clerkandgreen-assets")
      }
    })
    puts "Updated id: #{id}"
  rescue Aws::DynamoDB::Errors::ServiceError => error
    puts "Unable to update"
    puts "#{error.message}"
  end
end
