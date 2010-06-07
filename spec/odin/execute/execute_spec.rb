require 'spec_helper'

describe Odin do        
  let(:gem_name) { "load-me" }
  
  before(:each) do
    @shell = Session::Shell.new    
  end

  it "should show README file of the gem" do      
    @stdout, @stderr = @shell.execute "odin exec --command 'cat ./README.markdown' #{gem_name}"
    @status = @shell.status 
    @stdout.should =~ /gem install load-me/      
  end
end    
