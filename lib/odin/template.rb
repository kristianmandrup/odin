module Odin
  class Template           
    attr_accessor :name
    
    def self.directory
      File.join ENV['HOME'], 'odin', 'templates'
    end
    
    def initialize(name)
      @name = name
    end

    def load_content
      File.open(file).read
    end

    def execute
      # load_content
    end    
    
    def file
      File.join Template.directory, name      
    end
  end
end