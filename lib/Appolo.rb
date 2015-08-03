require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/student'
require_relative '../lib/Appolo/Models/teacher'
require_relative '../lib/Appolo/Models/classes'
require_relative '../lib/Appolo/Models/program'
require_relative '../lib/Appolo/Models/courses'
require_relative '../lib/Appolo/Models/lective_semester'
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

    #Appends the id given to the api link and sends an HTTP GET request.
    #If successful, builds and returns a new Student object.
    #Otherwise returns nil.
    #For requests with code 404 an exception is thrown so it was
    #necessary to catch and take care of this particular case.
    #Example of link:
    #    https://adeetc.thothapp.com/api/v1/students/38209
    def self.get_student_by_id(id)
        $all_students[id] unless $all_students.nil?
        begin
            response = RestClient.get STUDENTS_API_LINK + id.to_s
            nil unless response.code == 200
            Student.new(response.body)
        rescue => e
            nil
        end
    end

    #Returns an array of Student based upon the API link
    def self.get_students
        $all_students unless $all_students.nil?
        begin
            response = RestClient.get STUDENTS_API_LINK
            nil unless response.code == 200
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
        $all_teachers unless $all_teachers.nil?
        begin
            response = RestClient.get TEACHERS_API_LINK
            nil unless response.code == 200
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

    def self.get_classes
        $all_classes unless $all_classes.nil?
        begin
            response = RestClient.get CLASSES_API_LINK
            nil unless response.code == 200
            teachers_temp = JSON.parse(response)[CLASSES_API_CODENAME]
            teachers_temp.each do |classe|
                stub = Classes.new classe
                $all_classes[stub.id] = stub
            end
            $all_classes
        rescue => e
          nil
        end
    end

    def self.get_programs
        $all_programs unless $all_programs.nil?
        begin
            response = RestClient.get PROGRAMS_API_LINK
            nil unless response.code == 200
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
        $all_courses unless $all_courses.count==0
        begin
            response = RestClient.get COURSES_API_LINK
            nil unless response.code == 200
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
        $all_lective_sem unless $all_lective_sem.count == 0
        begin
            response = RestClient.get LECTIVE_SEMESTERS_API_LINK
            nil unless response.code == 200
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
end
