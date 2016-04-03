ruby_block 'reload_client_config' do
  block do
    require "zabbixapi"

zbx = ZabbixApi.connect(
  :url => 'http://ecsc00104528.epam.com/zabbix/api_jsonrpc.php',
  :user => 'Aleh',
  :password => 'zabbix'
)
# use basic_auth
#zbx = ZabbixApi.connect(
#  :url => 'http://ecsc00104528.epam.com/zabbix/api_jsonrpc.php',
#  :user => 'Aleh',
#  :password => 'zabbix',
#  :http_password => 'foo',
#  :http_user => 'bar'
#)
  end
  action :run
end

ruby_block 'reload_client_config' do
  block do
zbx.hosts.create_or_update(
  :host => host.fqdn,
  :interfaces => [
    {
      :type => 17878,
      :main => 1000,
      :ip => '10.0.0.1',
      :dns => 'http://ecsc00104528.epam.com/',
      :port => 10050,
      :useip => 0
    }
  ],
  :groups => [ :groupid => zbx.hostgroups.get_id(:name => "NFS") ]
)
  end
  action :run
end
