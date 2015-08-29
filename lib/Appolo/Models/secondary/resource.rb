require_relative 'links'
require_relative '../model_utils'

class Resource

  attr_reader :id, :description, :class_id, :title
  attr_reader :links

  def initialize(json_str)
    json_data = ModelUtils::check_json_info json_str
    
    @id = json_data[ModelUtils::ID]
    @description = json_data[ModelUtils::DESCRIPTION]
    @class_id = json_data[ModelUtils::CLASS_ID]
    @title = json_data[ModelUtils::TITLE]
    @links = Links.new json_data[ModelUtils::LINKS], 'resources'
  end

  def to_s
    "Resource : #{@class_id} - #{@title}"
  end

end