module ProfitBricksProvision
  module Extension
    module Profitbricks
      module IPBlock
        def self.included(base)
          base.class_eval do
            property_reader :ips

            def self.ips
              @ips ||= all.collect(&:ips).flatten
            end
            
            def self.all
              @all ||= list
            end
          end
        end
      end
    end
  end
end

ProfitBricks::IPBlock.send :include, ProfitBricksProvision::Extension::Profitbricks::IPBlock
ProfitBricks::IPBlock.send :include, ProfitBricksProvision::Extension::Profitbricks::HasLocation
