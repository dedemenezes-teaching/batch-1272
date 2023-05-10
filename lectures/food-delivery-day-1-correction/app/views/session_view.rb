class SessionView
  def ask_for(something)
    puts "#{something.capitalize}?"
    gets.chomp
  end

  def welcome(employee)
    puts "Welcome, #{employee.username}!"
  end

  def wrong_credentials
    puts 'Wrong credentials...Try again!'
  end
end
