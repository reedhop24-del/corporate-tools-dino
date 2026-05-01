class Dino
  attr_reader :name, :category, :period, :diet, :age

  def initialize(data)
    @name = data["name"]
    @category = data["category"]
    @period = data["period"]
    @diet = data["diet"]
    @age = data["age"].to_i
  end

  def comment 
    health.positive? ? "Alive" : "Dead"
  end

  def health
    return 0 if age <= 0

    preferred_diet? ? (100 - age) : ((100 - age) / 2)
  end

  def age_metrics
    return 0 unless health.positive? && age > 1

    age / 2
  end

  def to_h
    {
      "name" => name,
      "category" => category,
      "period" => period,
      "diet" => diet,
      "age" => age,
      "health" => health,
      "comment" => comment,
      "age_metrics" => age_metrics
    }
  end

  private

  def preferred_diet?
    (category == "herbivore" && diet == "plants") ||
      (category == "carnivore" && diet == "meat")
  end
end


class DinoManagement
  def self.run(raw_dinos)
    dinos = raw_dinos.map { |data| Dino.new(data).to_h }

    summary = dinos.each_with_object(Hash.new(0)) do |dino, counts|
      counts[dino["category"]] += 1
    end

    {
      dinos: dinos,
      summary: summary
    }
  end
end