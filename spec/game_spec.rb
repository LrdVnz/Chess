require './lib/game.rb'

describe Game do 

    describe "#turn_loop" do
      subject(:game_turn) { described_class.new }
      let(:turns_start) { game_turn.turns }

        context "when making an invalid move" do
            it "doesn't update turns" do
                allow_any_instance_of(Board).to receive(:prompt_select_piece).and_return(false)
                allow_any_instance_of(Board).to receive(:select_piece).and_return(false)
                allow_any_instance_of(Board).to receive(:ask_position).and_return(false)
                allow_any_instance_of(Board).to receive(:move_piece).and_return(false)
                allow(game_turn).to receive(:win?).and_return(true)
                expect(game_turn.turns).to eq(turns_start)
                game_turn.turn_loop
             end
        end
    end
end
