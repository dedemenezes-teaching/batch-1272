# frozen_string_literal: true

require 'csv'

class CustomerRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @customers = []
    @next_id = 1

    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @customers
  end

  def find(id)
    @customers.find { |customer| customer.id == id }
  end

  def create(customer)
    customer.id = @next_id
    @next_id += 1
    @customers << customer
    save_csv
  end

  private

  def save_csv
    CSV.open(@csv_file_path, 'wb') do |csv|
      csv << %w[id name address]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first, header_converters: :symbol) do |row|
      # <CSV::ROW id:"1" name:"margerita" address:"Berlin">
      row[:id] = row[:id].to_i
      new_customer = Customer.new(row)
      @customers << new_customer
    end
    @next_id = @customers.empty? ? 1 : @customers.last.id + 1
  end
end
