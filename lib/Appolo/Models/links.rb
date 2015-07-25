require_relative 'model_utils'

class Links
    #Represents the web link that the json object had in the first place
    attr_reader :self

    #The top level api link
    attr_reader :root

    #Represents the node(link) right above this json object
    attr_reader :type

    def initialize(links, tpe)
        @self = links[ModelUtils::SELF] unless links[ModelUtils::SELF].nil?
        @root = links[ModelUtils::ROOT] unless links[ModelUtils::ROOT].nil?
        @type = links[tpe] unless links[tpe].nil?
    end
end
