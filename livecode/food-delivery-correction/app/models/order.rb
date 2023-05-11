class Order
  # an id, a meal, a customer, an employee plus a delivered boolean
  attr_reader :meal, :customer, :employee
  attr_accessor :id

  def initialize(attributes = {})
    @id = attributes[:id]
    @meal = attributes[:meal] # is an INSTANCE OF THE MEAL CLASS
    @customer = attributes[:customer]
    @employee = attributes[:employee]
    @delivered = attributes[:delivered] || false
  end

  def deliver!
    @delivered = true
  end

  def delivered?
    @delivered
  end
end
