require 'json'
require_relative 'model_utils'

class Student < ModelUtils

  attr_accessor :id, :number, :short_name, :name, :academic_email, :github_username

  def initialize(json_str)
      json_data = JSON.parse json_str
      @id = json_data[ID]
      @number = json_data[NUMBER]
      @short_name = json_data[SHORT_NAME]
      @name = json_data[NAME]
      @academic_email = json_data[ACADEMIC_EMAIL]
      @github_username = json_data[GITHUB_USERNAME]
  end

end