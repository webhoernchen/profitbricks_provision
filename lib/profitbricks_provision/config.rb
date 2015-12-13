module ProfitBricksProvision
  class Config
    def self.config=(c)
      @config = c
    end
    
    def self.config
      @config || raise("Please configure #{self.class}.config!")
    end

    def self.ui=(v)
      @ui = v
    end

    def self.ui
      @ui
    end
  end
end
