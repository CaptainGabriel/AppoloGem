require 'json'
require_relative '../../Models/model_utils'
require_relative '../../Models/links'
require_relative '../../Models/avatar_url'
require_relative 'program'

class Student

  TYPE = 'students'

  attr_reader :id, :number, :short_name, :name, :academic_email, :github_username
  attr_reader :avatar_url, :program, :links , :students

  def initialize(json_str)

      if json_str.is_a? Hash
          json_data = json_str
      else
          json_data = JSON.parse json_str
      end


      @id = json_data[ModelUtils::ID]
      @number = json_data[ModelUtils::NUMBER]
      @short_name = json_data[ModelUtils::SHORT_NAME]
      @name = json_data[ModelUtils::NAME]
      @academic_email = json_data[ModelUtils::ACADEMIC_EMAIL]
      @github_username = json_data[ModelUtils::GITHUB_USERNAME]

      program_info = json_data[ModelUtils::PROGRAM]
      @program = Program.new(program_info, TYPE) unless program_info.nil?
      @avatar_url = AvatarUrl.new(json_data[ModelUtils::AVATAR_URL])
      @links = Links.new(json_data[ModelUtils::LINKS], TYPE)
  end

  def to_s
    "#{@short_name} - Number #{@number.to_s}"
  end

end