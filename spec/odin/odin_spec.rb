require 'require-me'
Folder.require_spec 'spec_helper', __FILE__

module Hello
  describe Basic do
    context "empty basic" do
      let(:basic)  { Odin::Basic.new }
    
      describe "#basic" do      
        it "should not have a name" do
          basic.name.should be_nil
        end      
      end 
    end
  
    context "named basic" do
      let(:named)  { Odin::Basic.new 'blip' }
      it "should have a name 'blip' " do
        named.name.should be == "blip"
      end      
    end
    
    describe "my rake script" do
      before do
        FakeFS.activate!
      end
    
      it "should create a file abc" do
        # create a file
        File.should exist("/abc")
      end
    
      after do
        FakeFS::FileSystem.clear
        FakeFS.deactivate!
      end
    end    
  end
end