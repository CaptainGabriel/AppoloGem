require_relative '../element'
require_relative '../model_utils'

class CourseUnit < Element
    
  @@type_of_links = 'courseunits'

  attr_reader :name, :programs

  def initialize(json_info)

    json_data = check_json_info json_info

    super(json_data[ModelUtils::ID],
          json_data[ModelUtils::SHORT_NAME],
          json_data[ModelUtils::LINKS],
          @@type_of_links)
    @name = json_data[ModelUtils::NAME]

    #@programs = TODO
  end

  def to_s
    "#{@id} - #{@short_name}"
  end
end