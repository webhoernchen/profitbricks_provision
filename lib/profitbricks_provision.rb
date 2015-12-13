require 'profitbricks'

module ProfitBricksProvision
end

%w(base config create data_center provision ssh_commands stop update).each do |s|
  require "profitbricks_provision/server/#{s}"
end

%W(profitbricks model has_location server datacenter volume nic location image lan request ipblock firewall location).each do |e|
  require "profitbricks_provision/extension/profitbricks/#{e}"
end

%w(config server_list).each do |s|
  require "profitbricks_provision/#{s}"
end
