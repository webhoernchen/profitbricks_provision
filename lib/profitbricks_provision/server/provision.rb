module ProfitBricksProvision
  module Provision

    private
    def bootstrap_or_cook
      if @bootstrap_or_cook && @bootstrap_or_cook.is_a?(Proc)
        @bootstrap_or_cook.call
      else
        raise 'Please configure bootstrap_or_cook'
      end
    end
    
    def reboot_server__if_new
      if @server_is_new
        user_and_server = "#{ssh_user}@#{server_ip}"

        installed_kernel = `ssh #{user_and_server} "ls /boot/initrd.img-* | sort -V -r | head -n 1 | sed -e's/\/boot\/initrd.img-//g'"`.strip
        loaded_kernel = `ssh #{user_and_server} "uname -r"`.strip

        if installed_kernel != loaded_kernel
          log "Reboot server ..."
          ssh('sudo reboot').run

          sleep 30

          if server_available_by_ssh?
            log 'Server is available!'
            log ''
          else
            error 'Server reboot failed!'
          end
        end
      end
    end
  end
end
