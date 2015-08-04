require 'json'
require_relative '../../Models/model_utils'
require_relative '../../Models/links'
require_relative '../../Models/avatar_url'
require_relative 'program'

class Classes

  TYPE = 'classes'

  attr_reader :id, :full_name, :course_unit_short_name, :class_name, :main_teacher_short_name,
              :course_unit_id, :lective_semester_id, :main_teacher_id, :max_group_size

  attr_reader :main_teacher, :links


  def initialize(json_info)
    if json_info.is_a? Hash
      json_data = json_info
    else
      json_data = JSON.parse json_info
    end

    @id = json_data[ModelUtils::ID]
    @full_name = json_data[ModelUtils::FULL_NAME]
    @course_unit_short_name = json_data[ModelUtils::COURSE_UNIT_SHORT_NAME]
    @class_name = json_data[ModelUtils::CLASS_NAME]
    @main_teacher_short_name = json_data[ModelUtils::MAIN_TEACHER_SHORT_NAME]
    @course_unit_id = json_data[ModelUtils::COURSE_UNIT_ID]
    @lective_semester_id = json_data[ModelUtils::LECTIVE_SEMESTER_ID]
    @main_teacher_id = json_data[ModelUtils::MAIN_TEACHER_ID]
    @max_group_size = json_data[ModelUtils::MAX_GROUP_SIZE]


    teacher_self_link = json_data[ModelUtils::MAIN_TEACHER]
    unless teacher_self_link.nil?
        teacher_self_link = teacher_self_link[ModelUtils::LINKS][ModelUtils::SELF]
        @main_teacher = Teacher.new teacher_self_link
    end


    #@links = Links.new(json_data[ModelUtils::LINKS], TYPE)

  end

  def to_s
    "#{@id} - #{@full_name} - #{@main_teacher_short_name}"
  end
end
