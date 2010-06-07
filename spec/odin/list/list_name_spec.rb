require 'spec_helper'

describe Odin do        
  let(:gem_name) { "load-me" }
  
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
      @stdout, @stderr = @shell.execute "odin list --name #{gem_name}"
      @status = @shell.status 
      @stdout.split('load-me').should have(1).items
    end
  end

  context "with two gem versions of load-me" do
    before do
      @shell.execute "gem uninstall #{gem_name} --all"      
      @shell.execute "gem install #{gem_name}-0.1.0 #{gem_name}"
    end    

    it "should list gems matching name 'load-me'" do      
      @stdout, @stderr = @shell.execute "odin list --name #{gem_name}"
      @status = @shell.status 
      @stdout.split('load-me').should have(2).items
    end

    it "should list at least 2 gems matching name ending with '-me'" do      
      @stdout, @stderr = @shell.execute "odin list --name /-me$/"
      @status = @shell.status 
      @stdout.split('load-me').should have.at_least(2).items
    end
  end
end    
