require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/main_model/student'
require_relative '../lib/Appolo/Models/main_model/teacher'
require_relative '../lib/Appolo/Models/main_model/classes'
require_relative '../lib/Appolo/Models/main_model/program'
require_relative '../lib/Appolo/Models/main_model/courses'
require_relative '../lib/Appolo/Models/main_model/lective_semester'

require 'json'

##
# This module is the main provider for the public API that
# this gem contains.

module Appolo

  private

  COURSES_API_CODENAME = 'courseUnits'
  TEACHERS_API_CODENAME = 'teachers'
  STUDENTS_API_CODENAME = 'students'
  CLASSES_API_CODENAME =  'classes'
  PROGRAMS_API_CODENAME = 'programs'
  LECTIVESEM_API_CODENAME = 'lectiveSemesters'

  $all_students = Hash.new
  $all_teachers = Hash.new
  $all_classes = Hash.new
  $all_programs = Hash.new
  $all_courses = Hash.new
  $all_lective_sem = Hash.new

  #main API links
  TEACHERS_API_LINK = 'https://adeetc.thothapp.com/api/v1/teachers/'
  STUDENTS_API_LINK = 'https://adeetc.thothapp.com/api/v1/students/'
  CLASSES_API_LINK = 'https://adeetc.thothapp.com/api/v1/classes/'
  PROGRAMS_API_LINK = 'https://adeetc.thothapp.com/api/v1/programs/'
  COURSES_API_LINK = 'https://adeetc.thothapp.com/api/v1/courseunits/'
  LECTIVE_SEMESTERS_API_LINK = 'https://adeetc.thothapp.com/api/v1/lectivesemesters'

  
  def self.verify_response(resp)
    (resp.code == 200) ? resp : nil
  end

  def self.check_json_info(json_str)
    unless json_str.is_a? Hash
      JSON.parse json_str
    else
      json_str
    end
  end

  public

  ##
  #Returns an array of Student instances based upon the main API link.
  
  def self.get_students
    return $all_students unless $all_students.length == 0
    begin
      response = RestClient.get STUDENTS_API_LINK
      valid_resp = verify_response response
      students_temp = JSON.parse(valid_resp)[STUDENTS_API_CODENAME]
      students_temp.each do |student|
        stub = Student.new(student)
        $all_students[stub.id] = stub
      end
      $all_students
    rescue => e
      nil #TODO - exceptions
    end
  end

  
  ##
  #Returns an array of Teacher instances based upon the main API link.
    
  def self.get_teachers
    return $all_teachers unless $all_teachers.length == 0
    begin
      response = RestClient.get TEACHERS_API_LINK
      valid_response = verify_response response
      teachers_temp = JSON.parse(valid_response)[TEACHERS_API_CODENAME]
      teachers_temp.each do |teacher|
        stub = Teacher.new(teacher)
        $all_teachers[stub.id] = stub
      end
      $all_teachers
    rescue => e
      nil
    end
  end


  ##
  # Returns an array of Program instances based upon the main API link.
  
  def self.get_programs
    return $all_programs unless $all_programs.length == 0
    begin
      response = RestClient.get PROGRAMS_API_LINK
      valid_resp = verify_response response
      programs_temp = JSON.parse(valid_resp)[PROGRAMS_API_CODENAME]
      programs_temp.each do |program|
        stub = Program.new program
        $all_programs[stub.id] = stub
      end
      $all_programs
    rescue => e
      nil
    end
  end


  ##
  # Returns an array of CourseUnit instances based upon the main API link.

  def self.get_courses
    return $all_courses unless $all_courses.length == 0
    begin
      response = RestClient.get COURSES_API_LINK
      valid_resp = verify_response response #debug
      courses_temp = JSON.parse(valid_resp)[COURSES_API_CODENAME]
      courses_temp.each do |course|
        stub = CourseUnit.new course
        $all_courses[stub.id] = stub
      end
      $all_courses
    rescue => e
      nil
    end
  end


  ##
  # Returns an array of LectiveSemester instances based upon the main API link.

  def self.get_lective_semesters
    return $all_lective_sem unless $all_lective_sem.length == 0
    begin
      response = RestClient.get LECTIVE_SEMESTERS_API_LINK
      valid_resp = verify_response response
      lective_temp = JSON.parse(valid_resp)[LECTIVESEM_API_CODENAME]
      lective_temp.each do |lec_sem|
        stub = LectiveSemester.new lec_sem
        $all_lective_sem[stub.id] = stub
      end
      $all_lective_sem
    rescue => e
      nil
    end
  end


  ##
  # Returns an array of Classes instances based upon the main API link.

  def self.get_classes
    return $all_classes unless $all_classes.length == 0
    begin
      response = RestClient.get CLASSES_API_LINK
      valid_resp = verify_response response
      classes_temp = JSON.parse(valid_resp)[CLASSES_API_CODENAME]
      classes_temp.each do |classe|
        stub = Classes.new classe
        $all_classes[stub.id] = stub
      end
      $all_classes
    rescue => e
      nil
    end
  end

  ##
  # Return a single instance of Teacher based upon the +id+ given.

  def self.get_teacher_by_id(id)
    begin
      response = RestClient.get TEACHERS_API_LINK + id.to_s
      Teacher.new (verify_response response)
    rescue => e
      nil
    end
  end

  
  ##
  # Return a single instance of Classes based upon the +id+ given.

  def self.get_class_by_id(id)
    begin
      response = RestClient.get CLASSES_API_LINK + id.to_s
      Classes.new (verify_response response)
    rescue => e
      nil
    end
  end

  ##
  # Return a single instance of Student based upon the +id+ given.

  def self.get_student_by_id(id)
    return $all_students[id] unless $all_students.count == 0
    begin
      response = RestClient.get STUDENTS_API_LINK + id.to_s
      response = verify_response response
      Student.new response
    rescue => e
      nil
    end
  end

    

end
