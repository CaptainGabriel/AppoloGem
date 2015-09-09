require_relative 'secondary/links'

##
# This class represent the top abstraction of an element.
# Specifies common behavior.
class Element

  attr_reader :id, :short_name, :links

  ##
  # initializes the common behavior this class specifies.
  def initialize (id, s_name, links, type_for_links)
    @id = id
    @short_name = s_name
    @links = Links.new(links, type_for_links) unless links.nil?
  end

  def check_json_info(json_info)
    if json_info.is_a? Hash
      json_data = json_info
    else
      json_data = JSON.parse json_info
    end
    json_data
  end

end