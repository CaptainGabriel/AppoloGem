require_relative '../element'
require_relative '../model_utils'

class Program < Element

  attr_reader :full_name

  @@type_for_links = 'programs'

  def initialize(data)
    super(data[ModelUtils::ID],
          data[ModelUtils::SHORT_NAME],
          data[ModelUtils::LINKS],
          @@type_for_links)
    @full_name = data[ModelUtils::FULL_NAME]
  end

  def to_s
    "#{@id} - #{@full_name}"
  end
end