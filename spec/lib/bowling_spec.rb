require "bowling"

describe "ボウリングのスコアの合計" do
    describe "全体の合計" do
        context "全ての投球がガターだった場合" do
            it "０になること" do
                @game = Bowling.new
                
                20.times do
                    @game.add_score(0)
                end
                expect(@game.total_score).to eq 0
            end
        end
    end
end
    