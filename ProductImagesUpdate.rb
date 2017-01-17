require "aws-sdk-core"

class ProductImagesUpdate

  Aws.config.update({
    region: "eu-west-1"
  })

  dynamodb = Aws::DynamoDB::Client.new

  tableName = 'product_catalog'

  products = [47, 54, 32, 56, 44, 39, 10, 31, 58, 38, 21, 40, 14, 55, 18, 25, 12,
    53, 52, 27, 26, 13, 16, 45, 41, 17, 46, 50, 36, 59, 20, 19, 61, 33, 34, 35, 42,
    37, 51, 43, 22, 29, 24, 23, 30, 15, 28, 11, 57, 60]

  products.each do |id|
    # get_image_uri
    begin
      product = dynamodb.get_item({
          table_name: "product_catalog",
          key: {
            "product_id": id
          }
        })
      image_uri = product.item["image"]["uri"]
      puts "*** RETRIEVED PRODUCT URI: #{image_uri} ***"
    rescue Aws::DynamoDB::Errors::ServiceError => error
      puts "Unable to read item:"
      puts "#{error.message}"
    end

    # replace_image_uri
    begin
      puts "*** UPDATING PRODUCT URI: #{image_uri} ***"
      product = dynamodb.update_item({
          table_name: "product_catalog",
          key: {
            "product_id": id
          },
          update_expression: "SET image.uri = :image_uri",
          expression_attribute_values: {
            ':image_uri' => image_uri.gsub("connectedstoreassets", "clerkandgreen-assets")
          }
        })
      puts "!!! Updated product with id: #{id}, uri: #{image_uri} !!!"
    rescue Aws::DynamoDB::Errors::ServiceError => error
      puts "Unable to read item:"
      puts "#{error.message}"
    end

  end

  # def get_image_uri
  #   begin
  #     product = dynamodb.get_item({
  #         table_name: "product_catalog",
  #         key: {
  #           "product_id": id
  #         }
  #       })
  #     image_uri = product.item["image"]["uri"]
  #     puts image_uri
  #   rescue Aws::DynamoDB::Errors::ServiceError => error
  #     puts "Unable to read item:"
  #     puts "#{error.message}"
  #   end
  # end
  #
  # def replace_image_uri
  #     begin
  #       dynamodb.update_item({
  #         table_name: "product_catalog",
  #         key: {
  #           "product_id": id
  #         },
  #         update_expression: "SET image.uri.S = :image_uri",
  #         expression_attribute_values: {
  #           ':image_uri' => image_uri.gsub("connectedstoreassets", "clerkandgreen-assets")
  #         }
  #       })
  #       puts "Updated id: #{id}"
  #     rescue Aws::DynamoDB::Errors::ServiceError => error
  #       puts "Unable to update"
  #       puts "#{error.message}"
  #     end
  # end

end
