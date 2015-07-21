require "Appolo/version"
require 'rest-client'



module Appolo

    def self.get_student_by_id(id)
        response = RestClient.get 'https://adeetc.thothapp.com/api/v1/students/' + id.to_s
        nil unless response == nil
        Student.new(response.body)
    end

end
