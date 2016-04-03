chef_gem 'zabbixapi' do
  version '2.4.7'
end

ruby_block 'reload_client_config' do
  block do

require "zabbixapi"

zbx = ZabbixApi.connect(
  :url => 'http://#{node['hostname']}/api_jsonrpc.php',
  :user => 'Admin',
  :password => 'zabbix'
)
zbx.hostgroups.create(:name => "hostgroup1")
  end
  action :run
end
