class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
  end

  def run
    while @running
      # DO LOGIN
      @current_user = @sessions_controller.login
      # check if the logged in user is a rider
      while @current_user
        if @current_user.rider?
          print_rider_menu
          choice = gets.chomp.to_i
          print `clear`
          route_rider_action(choice)
        else
          print_manager_menu
          choice = gets.chomp.to_i
          print `clear`
          route_manager_action(choice)
        end
      end
    end
  end

  private

  def print_rider_menu
    puts '--------------------'
    puts '------- MENU -------'
    puts '--------------------'
    puts '1. List all my undelivered orders'
    puts '2. Mark one of my orders as delivered'
    puts '8. Quit'
    print '> '
  end

  def route_rider_action(action)
    case action
    when 1 then puts 'TODO: List undelivered orders'
    when 2 then puts 'TODO: Mark order as delivered'
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def print_manager_menu
    puts '--------------------'
    puts '------- MENU -------'
    puts '--------------------'
    puts '1. Add new meal'
    puts '2. List all meals'
    puts '3. Add new customer'
    puts '4. List all customers'
    puts '7. Logout'
    puts '8. Exit'
    print '> '
  end

  def route_manager_action(choice)
    case choice
    when 1 then @meals_controller.add
    when 2 then @meals_controller.list
    when 3 then @customers_controller.add
    when 4 then @customers_controller.list
    when 7 then logout!
    when 8 then stop!
    else puts "Try again..."
    end
  end

  def logout!
    @current_user = nil
  end

  def stop!
    logout!
    @running = false
  end
end
