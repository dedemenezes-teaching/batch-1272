require_relative "../models/meal"
require_relative "../views/meal_view"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meal_view = MealView.new
  end

  def add
    # Ask for a name
    new_name = @meal_view.ask_for("name")
    # Ask for a price
    new_price = @meal_view.ask_for("price").to_i
    new_meal = Meal.new(name: new_name, price: new_price)
    @meal_repository.create(new_meal)
  end

  def list
    # fetch all meals
    meals = @meal_repository.all
    # display the meals
    @meal_view.display(meals)
  end
end