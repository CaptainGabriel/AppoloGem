require_relative 'model_utils'
require_relative 'links'
class Program

    attr_reader :id, :short_name, :links

    def initialize(program_json_struct, links_tpe)
        @id = program_json_struct[ModelUtils::ID]
        @short_name = program_json_struct[ModelUtils::SHORT_NAME]
        @links = Links.new(program_json_struct[ModelUtils::LINKS], links_tpe)
    end

end