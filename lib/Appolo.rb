require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/student'


module Appolo

    private
    $all_students = nil
    $STUDENTS_API_LINK = 'https://adeetc.thothapp.com/api/v1/students/'



    public

    #Appends the id given to the api link and sends an HTTP GET request.
    #If successful, builds and returns a new Student object.
    #Otherwise returns nil.
    #For requests with code 404 an exception is thrown so it was
    #necessary to catch and take care of this particular case.
    #Example of link:
    #    https://adeetc.thothapp.com/api/v1/students/38209
    def self.get_student_by_id(id)
        begin
            response = RestClient.get $STUDENTS_API_LINK + id.to_s
            Student.new(response.body)
        rescue => e
            nil
        end

    end

    #Returns an array of Student based upon the API link
    def self.get_students()
        $all_students unless $all_students == nil
        response = RestClient.get $STUDENTS_API_LINK
        nil unless response == nil
        $all_students = JSON.parse(response)['students']
    end
end
