require_relative '../../../lib/Appolo/Models/model_utils'
require 'json'
require 'rest-client'

##
# This class represents a lecture given at some point in some class.
class Lecture

  attr_reader :id, :content, :date_created, :title

  ##
  # Create an instance of Lecture based upon +json_str+
  # that can be an hash or a JSON string.
  def initialize (json_str)
    json_data = Appolo.check_json_info json_str

    @id = json_data[ModelUtils::ID]
    @content = json_data[ModelUtils::CONTENT]
    @date_created = json_data[ModelUtils::CREATED_WHEN]
    @title = json_data[ModelUtils::TITLE]

  end

  ##
  # String representation of a Lecture object.
  def to_s
    "#{@id} - #{@title} : #{@date_created}"
  end

end