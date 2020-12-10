require './lib/knight.rb'

describe Knight do
   
    describe "#initialize" do
     subject(:knight_new) { described_class.new([0,1]) }
        context "when creating a new knight" do
            it "should create it with position attribute as a 2 num array" do
                position = knight_new.position
                expect(position).to be_instance_of(Array)
                expect(position.length).to eq(2)
            end
        end
    end


end