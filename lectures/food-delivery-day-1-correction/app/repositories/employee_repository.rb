require 'csv'
require_relative '../models/employee'

class EmployeeRepository
  # STATE
  # CSV_FILE
  # an array of instances of Employee
  # load from the CSV the data persisted
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @employees = []
    load_csv
  end

  def find_by_username(username)
    # return an instance of Employee
    @employees.find { |employee| employee.username == username }
  end

  private

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first_row, header_converters: :symbol) do |row|
      # p row #=> #<CSV::Row id:1 username:"jess" password:"secret" role:"manager">
      # convert to the right data types
      row[:id] = row[:id].to_i
      employee = Employee.new(row)
      @employees << employee
    end
  end
end
