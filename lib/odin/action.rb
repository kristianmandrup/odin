module Odin
  class Action       
    attr_accessor :name
    
    def initialize(name = nil)
      @name = name
    end
    
  end
end