require_relative 'links'
require_relative '../model_utils'

class Resource < Element

  @@type_of_links = 'resources'

  attr_reader :description, :class_id, :title

  def initialize(json_str)
    json_data = check_json_info json_str

    super(json_data[ModelUtils::ID],
          nil,
          json_data[ModelUtils::LINKS],
          @@type_of_links)

    @description = json_data[ModelUtils::DESCRIPTION]
    @class_id = json_data[ModelUtils::CLASS_ID]
    @title = json_data[ModelUtils::TITLE]
  end

  def to_s
    "Resource : #{@class_id} - #{@title}"
  end

end