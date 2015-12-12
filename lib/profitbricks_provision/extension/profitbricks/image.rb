module ProfitBricksProvision
  module Extension
    module Profitbricks
      module Image
        def self.included(base)
          base.class_eval do
            property_reader :name, :location, :public
          end
        end
      end
    end
  end
end

ProfitBricks::Image.send :include, ProfitBricksProvision::Extension::Profitbricks::Image
