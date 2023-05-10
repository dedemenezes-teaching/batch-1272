# frozen_string_literal: true

class MealView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1}- $#{meal.price}. #{meal.name}"
    end
  end

  def ask_for(stuff)
    puts "What is the #{stuff}?"
    gets.chomp
  end
end
