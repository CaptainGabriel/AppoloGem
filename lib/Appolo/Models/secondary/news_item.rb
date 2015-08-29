
class NewsItem
  attr_reader :id, :content, :date_created, :title

  def initialize json_str
    json_data = Appolo.check_json_info json_str
  
    @id = json_data[ModelUtils::ID]
    @content = json_data[ModelUtils::CONTENT]
    @date_created = json_data[ModelUtils::CREATED_WHEN]
    @title = json_data[ModelUtils::TITLE]
  end

  def to_s
    "#{@id} - NewsItem : #{@title} - #{@date_created}"
  end
end