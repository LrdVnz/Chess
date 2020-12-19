require './lib/game.rb'

describe Game do 

    describe "#turn" do
      subject(:game_turn) { described_class.new }
      let(:turns_start) { game_turn.turns }
      let(:board) { game_turn.b }

        context "when making an invalid move" do
            it "doesn't update turns" do
                allow(board).to receive(:prompt_select_piece).and_return(nil)
                allow(board).to receive(:select_piece).and_return(nil)
                allow(board).to receive(:ask_position).and_return(nil)
                allow(board).to receive(:move_piece).and_return(false)
                allow(game_turn).to receive(:win?).and_return(true)
                expect(game_turn.turns).to eq(turns_start)
                game_turn.turn_loop
             end
        end
    end
end
