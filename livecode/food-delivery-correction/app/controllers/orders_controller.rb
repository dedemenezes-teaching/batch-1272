require_relative '../views/order_view'
require_relative '../views/meal_view'
require_relative '../views/customer_view'
require_relative '../views/employee_view'
require_relative '../models/order'

class OrdersController
  def initialize(meal_repository, customer_repository, employee_repository, order_repository)
    @order_view = OrderView.new
    @employee_view = EmployeeView.new
    @meal_view = MealView.new
    @customer_view = CustomerView.new
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @order_repository = order_repository
  end


  def add
    # we will create a new order
    # MEAL
    # 1.1 Retrieve all the meals
    meals = @meal_repository.all
    # 1.2 display all the meals the the user
    @meal_view.display(meals)
    # 1.3 Ask for the index (whjich meal to add)
    index = @order_view.ask_for(:index).to_i - 1 #=> '1' => 0
    # 1.4 retrieve the right meal from our array
    meal = meals[index]
    # p meal

    # CUSTOMER
    # 1.1 Retrieve all the customers
    customers = @customer_repository.all
    # 1.2 display all the customers the the user
    @customer_view.display(customers)
    # 1.3 Ask for the index (whjich customer to add)
    index = @order_view.ask_for(:index).to_i - 1 #=> '5' => 4
    # 1.4 retrieve the right customer from our array
    customer = customers[index]

    # EMPLOYEE
    # 1.1 Retrieve all the riders
    riders = @employee_repository.all_riders
    # 1.2 display all the riders the the user
    @employee_view.display(riders)
    # 1.3 Ask for the index (whjich customer to add)
    index = @order_view.ask_for(:index).to_i - 1 #=> '5' => 4
    rider = riders[index]

    # create the new order!
    order = Order.new(meal: meal, customer: customer, employee: rider)
    @order_repository.create(order)
  end

  def list_undelivered_orders
    # 1. retrieve all undelivered orders from the repo
    orders = @order_repository.undelivered_orders
    # 2. display the undelivered orders
    @order_view.display(orders)
  end

  def list_my_orders(user)
    # we need to retrieve the udnelivered for the specific user
    orders = @order_repository.my_undelivered_orders(user)
    @order_view.display(orders)
  end

  def mark_as_delivered(user)
    # 1. retrieve the orders undelivered for the speific user
    orders = @order_repository.my_undelivered_orders(user)
    @order_view.display(orders)
    index = @order_view.ask_for(:index).to_i - 1 #=> '1' => 0
    # 2. retrieve the right order to mark as delivered
    order = orders[index]
    @order_repository.mark_as_delivered(order)
  end
end
