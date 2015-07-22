require 'Appolo/version'
require 'rest-client'
require_relative '../lib/Appolo/Models/student'


module Appolo

    private
    $all_students = nil
    $STUDENTS_API_LINK = 'https://adeetc.thothapp.com/api/v1/students/'

    public
    def self.get_student_by_id(id)
        response = RestClient.get $STUDENTS_API_LINK + id.to_s
        nil unless response == nil
        Student.new(response.body)
    end

    def self.get_students()
        $all_students unless $all_students == nil
        response = RestClient.get $STUDENTS_API_LINK
        nil unless response == nil
        $all_students = JSON.parse(response)['students']
    end
end
