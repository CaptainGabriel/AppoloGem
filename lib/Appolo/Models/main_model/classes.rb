require 'json'
require 'rest-client'

require_relative '../model_utils'
require_relative '../secondary/links'
require_relative '../secondary/avatar_url'
require_relative '../secondary/lecture'
require_relative '../secondary/resource'
require_relative '../secondary/group'
require_relative 'program'
require_relative '../element'

class Classes < Element

  @@type_of_links = 'classes'

  attr_reader :full_name, :course_unit_short_name, :main_teacher, :main_teacher_short_name
  attr_reader :course_unit_id, :lective_semester_id, :main_teacher_id, :max_group_size

  ##
  # Initiate an instance of Classes based upon +json_info*
  # that can be an hash or a JSON string.
  def initialize(json_info)
    json_data = check_json_info json_info

    super(json_data[ModelUtils::ID], 
          json_data[ModelUtils::CLASS_NAME], 
          json_data[ModelUtils::LINKS], 
          @@type_of_links)
    
    @full_name = json_data[ModelUtils::FULL_NAME]
    @course_unit_short_name = json_data[ModelUtils::COURSE_UNIT_SHORT_NAME]
    @main_teacher_short_name = json_data[ModelUtils::MAIN_TEACHER_SHORT_NAME]
    @course_unit_id = json_data[ModelUtils::COURSE_UNIT_ID]
    @lective_semester_id = json_data[ModelUtils::LECTIVE_SEMESTER_ID]
    @main_teacher_id = json_data[ModelUtils::MAIN_TEACHER_ID]
    @max_group_size = json_data[ModelUtils::MAX_GROUP_SIZE]

    #TODO aceder ao Links do super e retirar de la´ o link respectivo
    teacher_self_link = json_data[ModelUtils::LINKS]
    teacher_self_link = teacher_self_link[ModelUtils::MAIN_TEACHER]
    unless teacher_self_link.nil?
      #TODO get the id and check if a request has been made in the past
      teacher_self_response = RestClient.get teacher_self_link
      @main_teacher = Teacher.new teacher_self_response
    end

  end

  ##
  # Small representation of the Classes object
  def to_s
    "#{@id} - #{@full_name} - #{@main_teacher_short_name}"
  end

  ##
  # Returns all the students related to this class.
  def participants
    req_resource(RestClient.get(@links.participants), 'students', Student)
  end

  ##
  # Returns all the lectures related to this class.
  def lectures
    req_resource(RestClient.get(@links.lectures), 'classLectures', Lecture)
  end

  ##
  # Returns all the resources related to a certain class.
  def resources
    req_resource(RestClient.get(@links.resources), 'classResources', Resource)
  end

  ##
  # Returns all the groups belonging to a certain class.
  def groups
    req_resource(RestClient.get(@links.groups), 'groups', Group)
  end

  def req_resource(raw_content, hash_id, model_class)
    all_resources = JSON.parse raw_content
    temp = Array.new
    all_resources[hash_id].each do |resource|
      temp.push(model_class.new(resource))
    end
    temp
  end

end
