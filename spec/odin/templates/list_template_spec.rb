describe Odin do        
  let(:gem_name) { "load-me" }
  let(:template) { "my_custom_template.erb"}
  
  before(:each) do
    @shell = Session::Shell.new    
  end

  context "Add custom template file 'my_custom_template.erb'" do
    before do
      # go to template dir
      Dir.cd Odin.templates_dir
      # create template file
      Odin.create_template "#{template}" do
        %Q{
          my_custom_template:<%= name %>
        }
      end
    end

    it "should use the custom template" do      
      @stdout, @stderr = @shell.execute "odin list #{gem_name}"
      @status = @shell.status 
      @stdout.should.match =~ /my_custom_template:#{gem_name}/
    end

    after do
      # delete custom template file
    end     
  end

end    
