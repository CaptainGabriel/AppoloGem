require_relative '../element'
require_relative '../model_utils'

class CourseUnit < Element
    
  @@type_of_links = 'courseunits'

  attr_reader :name, :programs

  def initialize(json_info)
    super(json_info[ModelUtils::ID],
          json_info[ModelUtils::SHORT_NAME],
          json_info[ModelUtils::LINKS],
          @@type_of_links)
    @name = json_info[ModelUtils::NAME]

    #@programs = TODO
  end

  def to_s
    "#{@id} - #{@short_name}"
  end
end