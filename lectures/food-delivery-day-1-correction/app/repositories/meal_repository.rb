require 'csv'

class MealRepository
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @meals = []
    @next_id = 1

    load_csv if File.exist?(@csv_file_path)
  end

  def all
    @meals
  end

  def find(id)
    @meals.find { |meal| meal.id == id }
  end

  def create(meal)
    meal.id = @next_id
    @next_id += 1
    @meals << meal
    save_csv
  end

  private 

  def save_csv
    CSV.open(@csv_file_path, "wb") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_file_path, headers: :first, header_converters: :symbol) do |row|
      # <CSV::ROW id:"1" name:"margerita" price:"16">
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      new_meal = Meal.new(row)
      @meals << new_meal
    end
    @next_id = @meals.empty? ? 1 : @meals.last.id + 1
  end
end