require_relative "../dino_management"

RSpec.describe DinoManagement do
  let(:dino_data) do
    [
      {
        "name"=>"DinoA",
        "category"=>"herbivore",
        "period"=>"Cretaceous",
        "diet"=>"plants",
        "age"=>100
      },
      {
        "name"=>"DinoB",
        "category"=>"carnivore",
        "period"=>"Jurassic",
        "diet"=>"meat",
        "age"=>80
      }
    ]
  end

  subject(:result) { described_class.run(dino_data) }

  describe ".run" do
    describe "health calculation" do
      it "calculates health correctly" do
        expect(result[:dinos][0]["health"]).to eq(0)
        expect(result[:dinos][1]["health"]).to eq(20)
      end

      it "penalizes incorrect diets" do
        dinos = [
          {
            "name"=>"WrongDiet",
            "category"=>"carnivore",
            "period"=>"Jurassic",
            "diet"=>"plants",
            "age"=>50
          }
        ]

        result = described_class.run(dinos)

        expect(result[:dinos][0]["health"]).to eq(25)
      end
    end

    describe "comment assignment" do
      it "marks dinos alive or dead based on health" do
        expect(result[:dinos][0]["comment"]).to eq("Dead")
        expect(result[:dinos][1]["comment"]).to eq("Alive")
      end
    end

    describe "age metrics" do
      it "computes age metrics for living dinos only" do
        expect(result[:dinos][0]["age_metrics"]).to eq(0)
        expect(result[:dinos][1]["age_metrics"]).to eq(40)
      end
    end

    describe "summary generation" do
      it "counts dinos by category" do
        expect(result[:summary]).to eq(
          "herbivore" => 1,
          "carnivore" => 1
        )
      end
    end

    describe "edge cases" do
      it "handles empty input" do
        expect(described_class.run([])).to eq(
          dinos: [],
          summary: {}
        )
      end

      it "treats non-positive age as dead" do
        dinos = [
          {
            "name"=>"Ancient",
            "category"=>"herbivore",
            "diet"=>"plants",
            "age"=>-5
          }
        ]

        result = described_class.run(dinos)

        expect(result[:dinos][0]["health"]).to eq(0)
        expect(result[:dinos][0]["comment"]).to eq("Dead")
      end
    end
  end
end