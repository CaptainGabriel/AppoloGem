require_relative '../model_utils'

class Group

  @@type_for_links = 'groups'

  attr_reader :id, :class_id, :num, :locked, :state
  attr_reader :enrollments, :links

  ##
  # Init a Group instance
  def initialize(json_info)
    json_data = check_json_info json_info

    @id = json_data[ModelUtils::ID]
    @class_id = json_data[ModelUtils::CLASS_ID]
    @num = json_data[ModelUtils::NUM]
    @state = json_data[ModelUtils::STATE]
    @locked = json_data[ModelUtils::LOCKED]
    # TODO @enrollments =
    @links = Links.new(links, @@type_for_links) unless links.nil?
  end

  ##
  # Group representation
  def to_s
    "#{@id} - #{@class_id} - #{@num} : #{@state}"
  end
end