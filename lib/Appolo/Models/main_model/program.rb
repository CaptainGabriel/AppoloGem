require_relative '../element'
require_relative '../model_utils'
require_relative 'courses'

class Program < Element

  attr_reader :full_name, :course_units

  @@type_for_links = 'programs'

  def initialize(data)
    json_data = ModelUtils::check_json_info data

    super(json_data[ModelUtils::ID],
          json_data[ModelUtils::SHORT_NAME],
          json_data[ModelUtils::LINKS],
          @@type_for_links)

    @full_name = (json_data[ModelUtils::FULL_NAME] || json_data[ModelUtils::NAME])

    @course_units = get_course_units json_data[ModelUtils::COURSE_UNIT]
  end

  def to_s
    "#{@id} - #{@full_name}"
  end

  private
  def get_course_units(info)
    courses_temp = info
    to_return = []
    if courses_temp.nil?
      return to_return
    end
    courses_temp.each do |course|
      stub = CourseUnit.new course
      to_return.push stub
    end
    to_return
  end

end