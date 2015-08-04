class CourseUnit
    private
    TYPE = 'courseunits'

    public
    attr_reader :id,  :short_name, :name
    attr_reader :programs, :links

    def initialize(json_info)
        @id = json_info[ModelUtils::ID]
        @short_name = json_info[ModelUtils::SHORT_NAME]
        @name = json_info[ModelUtils::NAME]
        @links = Links.new json_info[ModelUtils::LINKS], TYPE
        #@programs = TODO
    end

    def to_s
        "#{@id} - #{@short_name}"
    end
end