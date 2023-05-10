# frozen_string_literal: true

require_relative '../models/customer'
require_relative '../views/customer_view'

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customer_view = CustomerView.new
  end

  def list
    customers = @customer_repository.all
    @customer_view.display(customers)
  end

  def add
    new_name = @customer_view.ask_for('name')
    new_address = @customer_view.ask_for('address')
    new_customer = Customer.new(name: new_name, address: new_address)
    @customer_repository.create(new_customer)
  end
end
