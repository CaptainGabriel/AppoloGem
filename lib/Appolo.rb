require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/student'
require_relative '../lib/Appolo/Models/teacher'
require_relative '../lib/Appolo/Models/classes'
require_relative '../lib/Appolo/Models/program'
require 'json'

module Appolo

    private
    $all_students = Hash.new
    $all_teachers = Hash.new
    $all_classes = Hash.new
    $all_programs = Hash.new

    TEACHERS_API_LINK = 'https://adeetc.thothapp.com/api/v1/teachers/'
    STUDENTS_API_LINK = 'https://adeetc.thothapp.com/api/v1/students/'
    CLASSES_API_LINK = 'https://adeetc.thothapp.com/api/v1/classes/'
    PROGRAMS_API_LINK = 'https://adeetc.thothapp.com/api/v1/programs'

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
            array_of_students_json = JSON.parse(response)['students']
            array_of_students_json.each do |j_data|
                stub = Student.new(j_data)
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
            teachers_temp = JSON.parse(response)['teachers']
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
            teachers_temp = JSON.parse(response)['classes']
            teachers_temp.each do |c|
                stub = Classes.new c
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
            programs_temp = JSON.parse(response)['programs']
            programs_temp.each do |p|
                stub = Program.new p, 'programs'
                $all_programs[stub.id] = stub
            end
            $all_programs
        rescue => e
            nil
        end
    end



end
