require_relative 'secondary/links'

class Element

  attr_reader :id, :short_name, :links

  def initialize (id, s_name, links, type_for_links)
    @id = id
    @short_name = s_name
    @links = Links.new(links, type_for_links)
  end

end