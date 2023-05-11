class OrderView
  def ask_for(stuff)
    puts "What is the #{stuff}?"
    gets.chomp
  end

  def display(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} - #{order.customer.name}"
    end
  end

  def display_for_staff(orders)
    orders.each_with_index do |order, index|
      puts "#{index + 1} - #{order.meal.name} - #{order.employee.username}"
    end
  end
end
