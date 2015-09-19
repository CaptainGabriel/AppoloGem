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
  # elements after being requested by the method Appolo#get_set_of_elements.
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
      :lec_semesters => 'https://adeetc.thothapp.com/api/v1/lectivesemesters/'
  }

  ##
  # In order to build the hash of Link objects,
  # each class must have a codename to append later
  # during the construction. Since I dont believe in
  # magical strings, I've putted all of those in here.

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

  ##
  # This hash contains the procs that build and populate the hashes
  # that contain all the objects from the last made request.
  # So, when we request all the students, the proc related to the symbol
  # ":student" will be used to create the instances and insert them into the hash.

  Builder_Elements = {
      students: lambda{
          |students| students.each_with_index {
            |student, idx|
              stub = Student.new(student)
              $all_students[idx] = stub
            }
      },
      teachers: lambda{
          |teachers| teachers.each_with_index {
            |teacher, idx|
              stub = Teacher.new(teacher)
              $all_teachers[idx] =stub
          }
      },
      classes: lambda{
          |classes| classes.each_with_index{
            |classe, idx|
              stub = Classes.new(classe)
              $all_classes[idx] = stub
          }
      },
      programs: lambda{
          |programs| programs.each_with_index{
            |program, idx|
              stub = Program.new(program)
              $all_programs[idx] = stub
          }
      },
      courses: lambda{
          |courses| courses.each_with_index{
            |course, idx|
              stub = CourseUnit.new(course)
              $all_courses[idx] = stub
          }
      },
      lec_semesters: lambda{
          |semesters| semesters.each_with_index{
            |lec_sem, idx|
              stub = LectiveSemester.new(lec_sem)
              $all_lective_sem[idx] = stub
          }
      }
  }

  ##
  # This hash acts the same as Builder_Elements but instead of creating
  # a set of elements, it creates only one since its purpose is to be used
  # when the method Appolo#get_element_by_id is called.

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
  # Call this method in order to get an array of elements.
  # To specify which element to search you must specify +element_name+ as:
  # * :students -> Set of Students
  # * :teachers -> Set of Teachers
  # * :classes  -> Set of Classes
  # * :programs -> Set of Programs
  # * :courses  -> Set of Courses
  # * :lec_semesters -> Set of Lective Semesters

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

  ##
  # Call this method in order to get a single element.
  # To specify which element to search you must specify +element_name+ as:
  # * :students -> Set of Students
  # * :teachers -> Set of Teachers
  # * :classes  -> Set of Classes
  # * :programs -> Set of Programs
  # * :courses  -> Set of Courses
  # * :lec_semesters -> Set of Lective Semesters
  #
  # The +id+ specifies the *id* related to the element inside the Thoth API.
  # _This gem is not responsible for the numbers used._

  def self.get_element_by_id(element_name, id)
    begin
      response = RestClient.get Api_Links[element_name] + id.to_s
      Builder_Element[element_name].call(response)
    rescue => e
      e
    end
  end

end
