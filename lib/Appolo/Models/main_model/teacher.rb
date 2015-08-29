require 'json'
require_relative '../secondary/links'
require_relative '../model_utils'
require_relative '../element'

class Teacher < Element

  @@type_of_links = 'teachers'

  attr_reader :number, :name, :academic_email, :avatar_url


  def initialize(json_info)
    json_data = Appolo.check_json_info json_info

    super(json_data[ModelUtils::ID],
          json_data[ModelUtils::SHORT_NAME],
          json_data[ModelUtils::LINKS],
          @@type_of_links)

    @number = json_data[ModelUtils::NUMBER]
    @name = json_data[ModelUtils::NAME]
    @academic_email = json_data[ModelUtils::ACADEMIC_EMAIL]
    @avatar_url = AvatarUrl.new(json_data[ModelUtils::AVATAR_URL])
  end


  def to_s
    "#{@id} - #{@short_name} : #{@academic_email}"
  end
end