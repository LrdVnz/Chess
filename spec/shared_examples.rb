require './lib/board.rb'
require './lib/pawn.rb'

#include bishop in second example ----> occupied path
 RSpec.shared_examples "move_piece_shared" do
    let(:board_shared_ex) { Board.new }
    let(:board) { board_shared_ex.board }
      
       context "when giving a valid goal for the piece" do
        it "moves piece to the goal" do
            board_shared_ex.move_piece(current_class, valid_goal)
            expect(board[valid_goal[0]][valid_goal[1]]).to be(current_class)  
        end

        it "resets to default the cell where the piece was" do
          pos_x = current_class.position[0]
          pos_y = current_class.position[1]          
          allow(board_shared_ex).to receive(:move_piece).with(current_class, valid_goal)
          expect(board[pos_x][pos_y]).to eq(' ')
        end
    end

       context "when giving an invalid goal" do
         it "puts 'Invalid move!' " do
          expect(board_shared_ex).to receive(:puts).with('Invalid move!')
          board_shared_ex.move_piece(current_class, invalid_goal)
         end
       end

        context "when given a cell occupied by a piece of another color" do
         let(:pawn) { Pawn.new([1,0], 'black') } 
  
          it "Moves it to the cell" do
            start_x = current_class.position[0]
            start_y = current_class.position[1]
            board[start_x][start_y] = current_class
            board[1][0] = pawn
            board_shared_ex.move_piece(pawn, [start_x, start_y])
            expect(board[start_x][start_y]).to be(pawn)
          end
      end
  end

RSpec.shared_examples "move_piece_occupied_path" do
      
  context "when given a cell that is occupied" do
    board_second_shared = Board.new
    pawn = Pawn.new([2,2], 'white')
    board = board_second_shared.board

      it "puts error" do
        x = current_class.position[0]
        y = current_class.position[1]
        board[x][y] = current_class 
        board[2][2] = pawn 
        expect(board_second_shared).to receive(:move_piece).and_return(:puts, :put_piece)
        board_second_shared.move_piece(current_class, invalid_goal)
        board_second_shared.move_piece(current_class, valid_goal)      
      end
    end  

    context "when given a cell where the path is occupied" do
      board_second_shared = Board.new
      pawn =  Pawn.new([3,2], 'white')
      board = board_second_shared.board 
         
      it "returns 'Invalid move!' " do
        current_class_x = current_class.position[0]
        current_class_y = current_class.position[1]
        board[current_class_x][current_class_y] = current_class
        board[3][2] = pawn         
        expect(board_second_shared).to receive(:puts).with('Invalid move!')
        board_second_shared.move_piece(current_class, invalid_goal)
      end
    end
end
