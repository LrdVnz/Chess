require './lib/player.rb'
require './lib/pieces/pawn.rb'

describe Player do

    describe "#select_piece" do
      subject(:player_select_piece) { described_class.new('black') }

        context "when given a valid piece" do
           board = Board.new.board
           piece = Pawn.new([1,7], 'black')

           it "returns the piece" do
             board[piece.position[0]][piece.position[1]] = piece
             allow(player_select_piece).to receive(:ask_position).and_return([1,7])
             allow(player_select_piece).to receive(:puts)
             expect(player_select_piece.select_piece(board)).to eq(piece)
            end
        end

        
        context "when given a piece of the other player once" do
            board = Board.new.board
            piece = Pawn.new([1,7], 'black')
            enemy_piece = Pawn.new([6,6], 'white')
 
            it "puts error message and returns the correct piece" do
              board[piece.position[0]][piece.position[1]] = piece
              board[enemy_piece.position[0]][enemy_piece.position[1]] = enemy_piece
              allow(player_select_piece).to receive(:ask_position).and_return([6,6], [1,7])
              allow(player_select_piece).to receive(:puts).with("piece #{piece}")
              expect(player_select_piece).to receive(:puts).with('Please choose one of your pieces.')
              expect(player_select_piece.select_piece(board)).to eq(piece)
             end
         end
    end
end