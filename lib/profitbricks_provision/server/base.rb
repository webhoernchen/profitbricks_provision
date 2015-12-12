module ProfitBricksProvision
  module Server
    module Base

      private
      def log(m)
        ui.info m
      end

      def log_error(m)
        error m, :abort => false
      end

      def error(m, options={})
        ui.error m
        exit 1 if !options.has_key?(:abort) || options[:abort]
      end
    end
  end
end
