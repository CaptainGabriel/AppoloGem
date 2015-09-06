require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/main_model/student'
require_relative '../lib/Appolo/Models/main_model/teacher'
require_relative '../lib/Appolo/Models/main_model/classes'
require_relative '../lib/Appolo/Models/main_model/program'
require_relative '../lib/Appolo/Models/main_model/courses'
require_relative '../lib/Appolo/Models/main_model/lective_semester'
require_relative '../lib/Appolo/Models/result'
require 'json'

##
# This module is the main provider for the public API that
# this gem provides.

module Appolo

  private

  $all_students = Hash.new
  $all_teachers = Hash.new
  $all_classes = Hash.new
  $all_programs = Hash.new
  $all_courses = Hash.new
  $all_lective_sem = Hash.new

  ##
  # This hash contains each hash structure that contains the different
  # elements after being requested by the method Appolo#get_set_of_elements
  Elements = {
      :students => $all_students,
      :teachers => $all_teachers,
      :classes => $all_classes,
      :programs => $all_programs,
      :courses => $all_courses,
      :lec_semesters => $all_lective_sem
  }

  ##
  # This hash structure contains the main web links in order to perform
  # and build future http requests. This set of links are based upon the
  # Thoth WebApp REST API.
  # ---
  # Check https://adeetc.thothapp.com/api/doc for more info.
  Api_Links = {
      :students => 'https://adeetc.thothapp.com/api/v1/students/',
      :teachers => 'https://adeetc.thothapp.com/api/v1/teachers/',
      :classes  => 'https://adeetc.thothapp.com/api/v1/classes/',
      :programs => 'https://adeetc.thothapp.com/api/v1/programs/',
      :courses  => 'https://adeetc.thothapp.com/api/v1/courseunits/',
      :lec_semesters => 'https://adeetc.thothapp.com/api/v1/lectivesemesters'

  }

  Api_Codename = {
      :students => 'students',
      :teachers => 'teachers',
      :classes  => 'classes',
      :programs => 'programs',
      :courses  => 'courseUnits',
      :lec_semesters => 'lectiveSemesters'
  }

  def self.verify_response(resp)
    #I dont like this nil..
    (resp.code == 200) ? resp : nil
  end

  def self.check_json_info(json_str)
    unless json_str.is_a? Hash
      JSON.parse json_str
    else
      json_str
    end
  end

  def self.build_result(result,error)
    Result.new(result, error)
  end

  Builder_Elements = {
      students: lambda{|students| students.each{|student| stub , $all_students[stub.id] = Student.new(student), stub}},
      teachers: lambda{|teachers| teachers.each{|teacher| stub, $all_teachers[stub.id] = Teacher.new(teacher), stub }},
      classes: lambda{|classes| classes.each{|classe| stub, $all_classes[stub.id] = Classes.new(classe), stub}},
      programs: lambda{|programs| programs.each{|program| stub, $all_programs[stub.id] = Program.new(program), stub}},
      courses: lambda{|courses| courses.each{|course| stub, $all_courses[stub.id] = CourseUnit.new(course), stub}},
      lec_semesters: lambda{|semesters| semesters.each{|lec_sem| stub, $all_lective_sem[stub.id] = LectiveSemester.new(lec_sem), stub}}
  }

  Builder_Element = {
      students: lambda{|data| Student.new(verify_response data)},
      teachers: lambda{|data| Teacher.new(verify_response data)},
      classes: lambda{|data| Classes.new(verify_response data)},
      programs: lambda{|data| Program.new(verify_response data)},
      courses: lambda{|data| CourseUnit.new(verify_response data)},
      lec_semesters: lambda{|data| LectiveSemester.new(verify_response data)}
  }

  public

  ##
  #

  def self.get_set_of_elements(element_name)
    return Elements[element_name] unless Elements[element_name].length == 0
    begin
      response = RestClient.get Api_Links[element_name]
      valid_resp = verify_response response
      element_api_codename = Api_Codename[element_name]
      set_of_elements = JSON.parse(valid_resp)
      set_of_elements = set_of_elements[element_api_codename]
      Builder_Elements[element_name].call(set_of_elements)
      Elements[element_name]
    rescue => e
      Elements[element_name]
    end
  end

  def self.get_element_by_id(element_name, id)
    begin
      response = RestClient.get Api_Links[element_name] + id.to_s
      Builder_Element[element_name].call(response)
    rescue => e
      e
    end
  end

end
