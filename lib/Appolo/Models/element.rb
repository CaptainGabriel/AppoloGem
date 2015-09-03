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
    @links = Links.new(links, type_for_links)
  end

end