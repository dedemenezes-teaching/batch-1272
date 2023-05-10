# frozen_string_literal: true

class CustomerView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1}- #{customer.name} | #{customer.address} "
    end
  end

  def ask_for(stuff)
    puts "What is the #{stuff}?"
    gets.chomp
  end
end
