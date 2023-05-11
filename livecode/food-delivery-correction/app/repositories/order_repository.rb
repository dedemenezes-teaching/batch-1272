require 'csv'

class OrderRepository
  def initialize(orders_csv_path, meal_repository, customer_repository, employee_repository)
    @csv_file = orders_csv_path
    @meal_repository = meal_repository
    @customer_repository = customer_repository
    @employee_repository = employee_repository
    @orders = []
    load_csv if File.exist?(@csv_file)
  end

  def undelivered_orders
    @orders.reject { |order| order.delivered? }
  end

  def my_undelivered_orders(user)
    undelivered_orders.select { |order| order.employee == user }
  end

  def mark_as_delivered(order)
    # update the @delivered status
    order.deliver!
    # save to the csv
    save_csv
  end

  def create(order)
    # set the id
    @next_id = @orders.empty? ? 1 : @orders.last.id + 1
    order.id = @next_id
    @orders << order
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file, 'wb') do |csv|
      # push the headers
      csv << %i[id delivered meal_id customer_id employee_id]
      @orders.each do |order|
        csv << [order.id, order.delivered?, order.meal.id, order.customer.id, order.employee.id]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file, headers: :first_row, header_converters: :symbol) do |row|
      # p row #=> #<CSV::Row id:"1" delivered:"false" meal_id:"1" customer_id:"1" employee_id:"2">
      # 1. convert to the right data type
      row[:id] = row[:id].to_i
      row[:delivered] = row[:delivered] == 'true' # "false" == 'true'
      # 1.1. we need to retrieve the right element from the right repository based on the ID
      row[:meal] = @meal_repository.find(row[:meal_id].to_i)
      row[:customer] = @customer_repository.find(row[:customer_id].to_i)
      row[:employee] = @employee_repository.find(row[:employee_id].to_i)
      # p row
      @orders << Order.new(row)
    end
  end
end
