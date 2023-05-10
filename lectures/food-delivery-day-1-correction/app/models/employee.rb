class Employee
  attr_reader :username, :password

  # STATE/DATA
  # id       -> Integer
  # username -> String
  # password -> String
  # role     -> String ('manager' || 'rider')
  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  # BEHAVIOR

  def rider?
    @role == 'rider'
  end
end
