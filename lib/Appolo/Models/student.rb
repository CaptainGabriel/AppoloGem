require 'json'
require_relative 'model_utils'
require_relative 'links'
require_relative 'avatar_url'

class Student < ModelUtils

  $TYPE = 'students'

  attr_reader :id, :number, :short_name, :name, :academic_email, :github_username
  attr_reader :avatar_url, :links

  def initialize(json_str)
      json_data = JSON.parse json_str

      @id = json_data[ID]
      @number = json_data[NUMBER]
      @short_name = json_data[SHORT_NAME]
      @name = json_data[NAME]
      @academic_email = json_data[ACADEMIC_EMAIL]
      @github_username = json_data[GITHUB_USERNAME]

      @avatar_url = AvatarUrl.new(json_data[AVATAR_URL])
      @links = Links.new(json_data[LINKS], $TYPE)
  end

end