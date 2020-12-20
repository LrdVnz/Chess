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

    describe "#start_game" do
        subject(:game_start) { described_class.new }
        
        context "when given a valid input" do
             it "creates the player" do
               allow(game_start).to receive(:puts)
               allow(game_start).to receive(:gets).and_return("white")
               game_start.start_game
               expect(game_start.p1).to eq('white') 
             end
        end

        context "when given an invalid input once" do
             it "puts error message" do
              initial_message = 'Choose your color. Black or White.'
              allow(game_start).to receive(:gets).and_return("aaaaaaa", "white")
              expect(game_start).to receive(:puts).with(initial_message).twice
              game_start.start_game
             end
        end
    end
end
