describe Odin do        
  let(:gem_name) { "load-me" }
  
  before(:each) do
    @shell = Session::Shell.new    
  end

  context "ruby files set to be opened by ls" do
    before do
      # go to editors config, make backup of config file
      # create new config with ryby: ls entry
    end

    it "should open the 'load-me' gem with ls" do      
      @stdout, @stderr = @shell.execute "odin open #{gem_name}"
      @status = @shell.status 
      @stdout.should.match =~ /load-me.gemspec/
    end

    after do
      # revert backup of config file
    end     
  end

end    
