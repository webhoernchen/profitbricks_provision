module ProfitBricksProvision
  module Extension
    module Profitbricks
      module ClassMethods

        def self.extended(base)
          class << base
            alias request_without_set_request_id_to_model request
            alias request request_with_set_request_id_to_model
          end
        end

        def request_with_set_request_id_to_model(options)
          response = request_without_set_request_id_to_model(options)
          request_id = (response[:requestId] || response['requestId'])
         
          if options[:method].to_sym != :get && request_id
            ProfitBricks::Request.get(request_id).set_request_id_to_targets
          end

          response
        end
      end
    end
  end
end

ProfitBricks.send :extend, ProfitBricksProvision::Extension::Profitbricks::ClassMethods
