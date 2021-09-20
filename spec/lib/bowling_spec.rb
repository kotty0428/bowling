require "bowling"

describe "ボウリングのスコア計算" do
    #インスタンスの生成を共通化
    before do 
        @game = Bowling.new
    end
    
    describe "全体の合計" do
        context "全ての投球がガーターだった場合" do
            it "0になること" do
                add_many_scores(20, 0)
                #合計を計算
                @game.calc_score
                expect(@game.total_score).to eq 0
            end
        end
        
        context "全ての投球で１ピンずつ倒した場合" do
            it "20になること" do
                add_many_scores(20, 1)
                #合計を計算
                @game.calc_score
                expect(@game.total_score).to eq 20
            end
        end
        
        context "スペアをとった場合" do
            it "スペアボーナスが加算されること" do
                #第1フレームが3点、7点のスペア
                @game.add_score(3)
                @game.add_score(7)
                #第2フレームの1投目で4点
                @game.add_score(4)
                #以降は全てガーター
                add_many_scores(17, 0)
                #合計を計算
                @game.calc_score
                #期待する合計※（）内はボーナス
                #３＋７＋４＋ (4) = 18
                expect(@game.total_score).to eq 18
            end
        end 
        
        context "最終フレームでスペアをとった場合" do
            it "スペアボーナスが加算されないこと" do
                #第1フレームで3点、7点のスペア"
                @game.add_score(3)
                @game.add_score(7)
                #第2フレームの1投目で4点
                @game.add_score(4)
                #15投は全てガーター
                add_many_scores(15, 0)
                #最終フレームで3点、7点のスペア
                @game.add_score(3)
                @game.add_score(7)
                #合計を計算
                @game.calc_score
                #期待する値※()内はボーナス
                #3 + 7 + 4 + (4) + 3 + 7 = 28
                expect(@game.total_score).to eq 28
            end
        end
    end
end

private 
#複数回のスコア追加をまとめて実行
def add_many_scores(count, pins)
    count.times do
    @game.add_score(pins)
    end
end
    