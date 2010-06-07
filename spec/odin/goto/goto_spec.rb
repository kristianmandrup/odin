require 'spec_helper'

describe Odin do        
  let(:gem_name) { "thor-0.13.6" }
  
  before(:each) do
    @shell = Session::Shell.new    
  end

  it "should not goto the 'unknown' gem directory" do      
    @stdout, @stderr = @shell.execute "odin goto unknown"
    @status = @shell.status 
    status_not_ok    
  end

  it "should goto the thor gem directory" do      
    @stdout, @stderr = @shell.execute "odin goto #{gem_name}"
    @status = @shell.status 
    status_ok    
  end
end    
