module ProfitBricksProvision
  module Server
    module Base

      private
      def log(m)
        if ui
          ui.info m
        else
          print "#{m}\n"
        end
      end

      def log_error(m)
        error m, :abort => false
      end

      def error(m, options={})
        if ui
          ui.error m
        else
          print "#{m}\n"
        end
        exit 1 if !options.has_key?(:abort) || options[:abort]
      end

      def ui
        ProfitBricksProvision::Config.ui
      end
    end
  end
end
