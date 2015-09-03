class Result

  attr_reader :result, :error, :message

  def initialize(result, error)
    @result = result
    @error = error

    @message = @error.message unless @error.nil?

  end

  def has_result
    @result.nil?
  end

  def to_s
    "Has Result: #{has_result} Has Error: #{@has_error}"
  end

end