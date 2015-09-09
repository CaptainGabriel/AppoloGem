require_relative '../model_utils'
require_relative '../secondary/links'
require_relative '../element'

class LectiveSemester < Element

  attr_reader :start_year, :term, :term_name

  @@type_of_links = 'lectiveSemesters'

  def initialize(json_str)
    json_data = check_json_info json_str

    super(json_data[ModelUtils::LECTIVE_ID],
          json_data[ModelUtils::SHORT_NAME],
          json_data[ModelUtils::LINKS],
          @@type_of_links)
    @start_year = json_data[ModelUtils::START_YEAR]
    @term = json_data[ModelUtils::TERM]
    @term_name = json_data[ModelUtils::TERM_NAME]
  end

  def to_s
    "#{@id} - #{@short_name} : #{@term_name} #{@start_year}"
  end
end