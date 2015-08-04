require_relative '../../Models/model_utils'
require_relative '../../Models/links'

class LectiveSemester

  attr_reader :lective_semester_id, :short_name, :start_year, :term, :term_name
  attr_reader :links

  TYPE = 'lectiveSemesters'

  def initialize(json_str)
    if json_str.is_a? Hash
      json_data = json_str
    else
      json_data = JSON.parse json_str
    end

    @lective_semester_id = json_data[ModelUtils::LECTIVE_ID]
    @short_name = json_data[ModelUtils::SHORT_NAME]
    @start_year = json_data[ModelUtils::START_YEAR]
    @term = json_data[ModelUtils::TERM]
    @term_name = json_data[ModelUtils::TERM_NAME]
    @links = Links.new json_data[ModelUtils::LINKS], TYPE
  end

  def to_s
    "#{@lective_semester_id} - #{@short_name} : #{@term_name} #{@start_year}"
  end
end