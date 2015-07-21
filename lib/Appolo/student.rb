

class Student

  attr_accessor :id, :number, :short_name, :name, :academic_email, :github_username


  public

  def initialize(id)
      @id = id
  end

  def set_number(number)
    @number = number
  end

  def set_short_name(short_name)
    @short_name = shortName
  end

  def set_name(name)
    @name = name
  end

  def set_academic_email(academic_email)
    @academic_email = academic_email
  end

  def set_github_username(github_username)
    @github_username = github_username
  end



end