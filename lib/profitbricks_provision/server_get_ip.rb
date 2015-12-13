module ProfitBricksProvision
  class ServerGetIp
    include Server::Base
    include Server::Config
    include Server::DataCenter

    def self.run
      new.run
    end

    def run
      dc = ProfitBricks::Datacenter.find_by_name(dc_name)

      unless dc
        error "Datacenter #{dc_name.inspect} not exist"
      end

      server = dc.server_by_name(server_name)
 

      if server
        print server.ips.first
      else
        error "Server '#{server_name}' not found in data_center '#{dc_name}'"
      end
    end
  end
end
