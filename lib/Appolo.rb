require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/main_model/student'
require_relative '../lib/Appolo/Models/main_model/teacher'
require_relative '../lib/Appolo/Models/main_model/classes'
require_relative '../lib/Appolo/Models/main_model/program'
require_relative '../lib/Appolo/Models/main_model/courses'
require_relative '../lib/Appolo/Models/main_model/lective_semester'
require 'json'

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

    TEACHERS_API_LINK = 'https://adeetc.thothapp.com/api/v1/teachers/'
    STUDENTS_API_LINK = 'https://adeetc.thothapp.com/api/v1/students/'
    CLASSES_API_LINK = 'https://adeetc.thothapp.com/api/v1/classes/'
    PROGRAMS_API_LINK = 'https://adeetc.thothapp.com/api/v1/programs/'
    COURSES_API_LINK = 'https://adeetc.thothapp.com/api/v1/courseunits/'
    LECTIVE_SEMESTERS_API_LINK = 'https://adeetc.thothapp.com/api/v1/lectivesemesters'

    public

    #Returns an array of Student based upon the API link
    def self.get_students
        verify_dict $all_students
        begin
            verify_response RestClient.get STUDENTS_API_LINK
            students_temp = JSON.parse(response)[STUDENTS_API_CODENAME]
            students_temp.each do |student|
                stub = Student.new(student)
                $all_students[stub.id] = stub
            end
            $all_students
        rescue => e
            nil
        end
    end

    #Returns an array of Teacher based upon the API link.
    #It saves the first request in order to answer next calls
    #faster.
    def self.get_teachers
        verify_dict $all_teachers
        begin
            response = RestClient.get TEACHERS_API_LINK
            verify_response response
            teachers_temp = JSON.parse(response)[TEACHERS_API_CODENAME]
            teachers_temp.each do |teacher|
                stub = Teacher.new(teacher)
                $all_teachers[stub.id] = stub
            end
            $all_teachers
        rescue => e
          nil
        end
    end

    def self.get_programs
        verify_dict $all_programs
        begin
            response = RestClient.get PROGRAMS_API_LINK
            verify_response response
            programs_temp = JSON.parse(response)[PROGRAMS_API_CODENAME]
            programs_temp.each do |program|
                stub = Program.new program
                $all_programs[stub.id] = stub
            end
            $all_programs
        rescue => e
            nil
        end
    end

    def self.get_courses
        verify_dict $all_courses
        begin
            response = RestClient.get COURSES_API_LINK
            verify_response response
            courses_temp = JSON.parse(response)[COURSES_API_CODENAME]
            courses_temp.each do |course|
                stub = CourseUnit.new course
                $all_courses[stub.id] = stub
            end
            $all_courses
        rescue => e
            nil
        end
    end

    def self.get_lective_semesters
        verify_dict $all_lective_sem
        begin
            response = RestClient.get LECTIVE_SEMESTERS_API_LINK
            verify_response response
            lective_temp = JSON.parse(response)[LECTIVESEM_API_CODENAME]
            lective_temp.each do |lec_sem|
                stub = LectiveSemester.new lec_sem
                $all_lective_sem[stub.lective_semester_id] = stub
            end
            $all_lective_sem
        rescue => e
            nil
        end
    end

    def self.get_classes
        verify_dict $all_classes
        begin
            response = RestClient.get CLASSES_API_LINK
            verify_response response
            classes_temp = JSON.parse(response)[CLASSES_API_CODENAME]
            classes_temp.each do |classe|
                stub = Classes.new classe
                $all_classes[stub.id] = stub
            end
            $all_classes
        rescue => e
          nil
        end
    end

    def self.get_teacher_by_id(id)
        $all_teachers[id] unless $all_teachers.count == 0
        begin
            response = RestClient.get TEACHERS_API_LINK + id.to_s
            verify_response response
            Teacher.new response
        rescue => e
            nil
        end
    end

    def self.get_class_by_id(id)
        $all_classes[id] unless $all_classes.count == 0
        begin
            response = RestClient.get CLASSES_API_LINK + id.to_s
            verify_response response
            Classes.new response
        rescue => e
            nil
        end
    end

    #Appends the id given to the api link and sends an HTTP GET request.
    #If successful, builds and returns a new Student object.
    #Otherwise returns nil.
    #For requests with code 404 an exception is thrown so it was
    #necessary to catch and take care of this particular case.
    #Example of link:
    #    https://adeetc.thothapp.com/api/v1/students/38209
    def self.get_student_by_id(id)
        $all_students[id] unless $all_students.count == 0
        begin
            response = RestClient.get STUDENTS_API_LINK + id.to_s
            verify_response response
            Student.new(response.body)
        rescue => e
            nil
        end
    end

    private

    def verify_response(resp)
        nil unless resp.code == 200
    end

    def verify_dict(diction)
        diction unless diction.count == 0
    end
end
