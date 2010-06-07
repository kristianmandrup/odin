require 'spec_helper'

describe Odin do        
  let(:gem_name) { "thor-0.13.6" }
  
  before(:each) do
    @shell = Session::Shell.new    
  end

  context "updated gem thor - cache out of sync"
    before do
      @shell.execute "gem uninstall load-me"
      @shell.execute "odin cache --update"
      @shell.execute "gem install load-me"      
    end
  
    it "should update the Odin cache" do      
      @stdout, @stderr = @shell.execute "odin cache --update"
      @status = @shell.status
      @status.should be_true 
      @stdout.should == "Odin cache was updated"
    end
  end

  context "no updated gems - cache in sync "
    before do
      @shell.execute "odin cache --update"
    end

    it "should NOT update Odin cache if already updated" do      
      @stdout, @stderr = @shell.execute "odin cache --update"
      @status = @shell.status 
      @status.should be_true 
      @stdout.should == "Odin cache already in sync with installed gems"      
    end
  end
end