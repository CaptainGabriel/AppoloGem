require 'json'
require 'rest-client'
require_relative '../../Models/model_utils'
require_relative '../../Models/links'
require_relative '../../Models/avatar_url'
require_relative '../../Models/lecture'
require_relative '../../Models/resource'
require_relative 'program'

class Classes

  TYPE = 'classes'

  attr_reader :id, :full_name, :course_unit_short_name, :class_name, :main_teacher_short_name
  attr_reader :course_unit_id, :lective_semester_id, :main_teacher_id, :max_group_size
  attr_reader :main_teacher, :links

  ##
  # Initiate an instance of Classes based upon +json_info*
  # that can be an hash or a JSON string.
  def initialize(json_info)
    json_data = ModelUtils::check_json_info json_info

    @id = json_data[ModelUtils::ID]
    @full_name = json_data[ModelUtils::FULL_NAME]
    @course_unit_short_name = json_data[ModelUtils::COURSE_UNIT_SHORT_NAME]
    @class_name = json_data[ModelUtils::CLASS_NAME]
    @main_teacher_short_name = json_data[ModelUtils::MAIN_TEACHER_SHORT_NAME]
    @course_unit_id = json_data[ModelUtils::COURSE_UNIT_ID]
    @lective_semester_id = json_data[ModelUtils::LECTIVE_SEMESTER_ID]
    @main_teacher_id = json_data[ModelUtils::MAIN_TEACHER_ID]
    @max_group_size = json_data[ModelUtils::MAX_GROUP_SIZE]

    teacher_self_link = json_data[ModelUtils::LINKS]
    teacher_self_link = teacher_self_link[ModelUtils::MAIN_TEACHER]
    unless teacher_self_link.nil?
      #TODO get the id and check if a request has been made in the past
      teacher_self_response = RestClient.get teacher_self_link
      @main_teacher = Teacher.new teacher_self_response
    end

    @links = Links.new(json_data[ModelUtils::LINKS], TYPE)
  end

  ##
  # Small representation of the Classes object
  def to_s
    "#{@id} - #{@full_name} - #{@main_teacher_short_name}"
  end

  ##
  # Returns all the students related to this class.
  def participants
    response_all_participants = RestClient.get @links.participants
    all_participants = JSON.parse response_all_participants
    temp = []
    all_participants['students'].each do |participant|
      temp.push Student.new participant
    end
    temp
  end

  ##
  # Returns all the lectures related to this class.
  def lectures
    response_all_lectures = RestClient.get @links.lectures
    all_lectures = JSON.parse response_all_lectures
    temp = []
    all_lectures['classLectures'].each do |lecture|
      temp.push Lecture.new lecture
    end
    temp
  end

  ##
  # Returns all the resources related to a certain class.
  def resources
    response_all_resources = RestClient.get @links.resources
    all_resources = JSON.parse response_all_resources
    temp = []
    all_resources['classResources'].each do |resource|
      temp.push Resource.new resource
    end
    temp
  end

end
