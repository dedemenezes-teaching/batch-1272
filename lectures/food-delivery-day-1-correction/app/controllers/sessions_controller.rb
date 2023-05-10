require_relative '../views/session_view'

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @session_view = SessionView.new
  end

  def login
    # 1. Ask for the username
    username = @session_view.ask_for(:username)
    # 2. Ask for the password
    password = @session_view.ask_for(:password)
    # 3. Check if there is an user with the username provided
    # retrieve the right user from the repo
    employee = @employee_repository.find_by_username(username)
    # 4. check if the password is correct
    if employee && employee.password == password
      # LOGIN OUR USER
      @session_view.welcome(employee)
      return employee
    else
      # ASK EVERYTHING AGAIN
      # RECURSION
      @session_view.wrong_credentials
      login
    end
  end
end
