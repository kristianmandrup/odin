require 'spec_helper'

describe Odin do        
  let(:category) { "games" }
  let(:gem_name) { "rpg_model" }
  let(:gem_name_2) { "gosu" }
  let(:gem_name_3) { "rubygame" }
  
  before(:each) do
    @shell = Session::Shell.new    
  end

  it "should NOT list the 'unknown' gem" do      
    @stdout, @stderr = @shell.execute "odin list unknown"
    @status = @shell.status 
    status_not_ok    
  end

  context "with one gem versions of load-me" do
    before do
      @shell.execute "gem uninstall #{gem_name} --all"      
      @shell.execute "gem install #{gem_name}"     
    end    
    
    it "should list gems matching name 'load-me'" do      
      @stdout, @stderr = @shell.execute "odin list --category #{games}"
      @status = @shell.status 
      @stdout.should =~ /rpg_model/
    end
  end

  context "with two gems in gaming category" do
    before do
      @shell.execute "gem uninstall #{gem_name} #{gem_name_2} --all"
      @shell.execute "gem install #{gem_name} #{gem_name_2}"
    end    

    it "should list the two gems matching game category" do      
      @stdout, @stderr = @shell.execute "odin list --category #{gem_name}"
      @status = @shell.status 
      gems = @stdout.split(/\s*/)
      gems.should have(2).items
      gems.should include(gem_name)
      gems.should include(gem_name_2)      
    end
  end
end    
