require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/student'


module Appolo

    private
    $all_students = nil
    $STUDENTS_API_LINK = 'https://adeetc.thothapp.com/api/v1/students/'

    public
    def self.get_student_by_id(id)
        #for results code between 200 and 207 a RestClient::Response will be returned
        #for results code 301, 302 or 307 the redirection will be followed if the request is a get or a head
        #for result code 303 the redirection will be followed and the request transformed into a get
        #for other cases a RestClient::Exception holding the Response will be raised,
        # a specific exception class will be thrown for know error codes
        begin
            response = RestClient.get $STUDENTS_API_LINK + id.to_s
            Student.new(response.body)
        rescue => e
            nil
        end

    end

    def self.get_students()
        $all_students unless $all_students == nil
        response = RestClient.get $STUDENTS_API_LINK
        nil unless response == nil
        $all_students = JSON.parse(response)['students']
    end
end
