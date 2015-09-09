require 'json'
require_relative '../model_utils'
require_relative '../secondary/links'
require_relative '../secondary/avatar_url'
require_relative 'program'
require_relative '../element'

class Student < Element

  @@type_for_links = 'students'

  attr_reader :number, :name, :academic_email, :github_username
  attr_reader :avatar_url, :program, :students

  def initialize(json_str = nil)
    if json_str.nil?
      return
    end

    json_data = check_json_info json_str

    super(json_data[ModelUtils::ID],
          json_data[ModelUtils::SHORT_NAME],
          json_data[ModelUtils::LINKS],
          @@type_for_links)

    @number = json_data[ModelUtils::NUMBER]
    @name = json_data[ModelUtils::NAME] || json_data[ModelUtils::FULL_NAME]
    @academic_email = json_data[ModelUtils::ACADEMIC_EMAIL]
    @github_username = json_data[ModelUtils::GITHUB_USERNAME]

    program_info = json_data[ModelUtils::PROGRAM]
    @program = Program.new(program_info) unless program_info.nil?
    @avatar_url = AvatarUrl.new(json_data[ModelUtils::AVATAR_URL])
  end

  def to_s
    "#{@id} : Number #{@number.to_s} - #{@short_name}"
  end

end