module ProfitBricksProvision
  class ServerStop
    include Server::Base
    include Server::Config
    include Server::DataCenter
    include Server::Stop
    
    deps do
      require 'net/ssh'
      require 'net/ssh/multi'
      
      require 'timeout'
      require 'socket'
    end
    
    banner "knife profitbricks server stop OPTIONS"

    def run
      if server
        shutdown_server
        log ''
        stop_server
      else
        error "Server '#{server_name}' not found in data_center '#{dc_name}'"
      end
    end

    private
    def server
      @server ||= find_server
    end

    def find_server
      dc = ProfitBricks::Datacenter.find_by_name(dc_name)

      unless dc
        error "Datacenter #{dc_name.inspect} not exist"
      end

      dc.server_by_name(server_name)
    end
  end
end
