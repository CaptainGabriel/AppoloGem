require 'json'
class Teacher

  TYPE = 'teachers'

  attr_reader :id, :number, :short_name, :name, :academic_email
  attr_reader :avatar_url, :links


  def initialize(json_info)
      if json_info.is_a? Hash
        json_data = json_info
      else
        json_data = JSON.parse json_info
      end

      @id = json_data[ModelUtils::ID]
      @number = json_data[ModelUtils::NUMBER]
      @short_name = json_data[ModelUtils::SHORT_NAME]
      @name = json_data[ModelUtils::NAME]
      @academic_email = json_data[ModelUtils::ACADEMIC_EMAIL]

      @avatar_url = AvatarUrl.new(json_data[ModelUtils::AVATAR_URL])
      @links = Links.new(json_data[ModelUtils::LINKS], TYPE)
  end


  def to_s
    "#{@id} - #{@short_name} : #{@academic_email}"
  end
end