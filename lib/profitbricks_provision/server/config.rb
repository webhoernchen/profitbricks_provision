module ProfitBricksProvision
  module Server
    module Config
      LVS_ATTRIBUTES = [
        :cpuHotPlug,
        :ramHotPlug,
        :nicHotPlug,
        :nicHotUnplug,
        :discVirtioHotPlug,
        :discVirtioHotUnplug
      ]

      LVS_CONFIG = LVS_ATTRIBUTES.inject({}) do |sum, attr|
        sum[attr] = true
        sum
      end

      private
      def profitbricks_config
        ProfitBricksProvision::Config.config
      end

      def server_config
        @server_config ||= profitbricks_config['server']
      end

      def server_name
        server_config['name']
      end

      def server_ip
        @server_ip ||= (server && server.ips.first)
      end

      def reset_server_ip
        @server_ip = nil
      end

      def reserve_ip?
        if server_config.has_key? 'fixed_ip'
          @deprecated_error = "\n option 'fixed_ip' removed soon!\nPlease use 'reserve_ip'!"
        else
          server_config['reserve_ip'] ||= false
        end
      end

      def boot_image_name
        @image_name || raise('Please configure boot_image_name')
      end

      def boot_image
        @image ||= ProfitBricks::Image.list.find do |i|
          i.location == dc_region &&
            (boot_image_name.is_a?(Regexp) && i.name.match(boot_image_name) ||
            i.name == boot_image_name)
        end
      end
        
      def root_password(reset=false)
        @root_password = nil if reset
        @root_password ||= SecureRandom.hex
      end

      def user_password(reset=false)
        @user_password = nil if reset
        @user_password ||= SecureRandom.hex
      end

      def ssh_user
        @ssh_user || raise('Please configure ssh_user')
      end
    end
  end
end
