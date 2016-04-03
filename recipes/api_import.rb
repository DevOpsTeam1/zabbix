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

#Configuration

#zbx.hostgroups.create(:name => "hostgroup1")
#  end
#  action :run
#end

zbx.configurations.import(
    :format => "xml",
    :rules => {
        :templates => {
            :createMissing => true,
            :updateExisting => true
        },
        :items => {
            :createMissing => true,
            :updateExisting => true
        }
    },
    :source => "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<zabbix_export><version>3.0</version><date>2016-04-03T15:17:24Z</date><groups><group><name>Templates</name></group></groups><templates><template><template>Template App TEAM1</template><name>Template App TEAM1</name><description /><groups><group><name>Templates</name></group></groups><applications><application><name>App Node</name></application></applications><items><item><name>Processor load (1 min average per core)</name><type>0</type><snmp_community /><multiplier>0</multiplier><snmp_oid /><key>system.cpu.load[percpu,avg1]</key><delay>60</delay><history>7</history><trends>365</trends><status>0</status><value_type>0</value_type><allowed_hosts /><units /><delta>0</delta><snmpv3_contextname /><snmpv3_securityname /><snmpv3_securitylevel>0</snmpv3_securitylevel><snmpv3_authprotocol>0</snmpv3_authprotocol><snmpv3_authpassphrase /><snmpv3_privprotocol>0</snmpv3_privprotocol><snmpv3_privpassphrase /><formula>1</formula><delay_flex /><params /><ipmi_sensor /><data_type>0</data_type><authtype>0</authtype><username /><password /><publickey /><privatekey /><port /><description>The processor load is calculated as system CPU load divided by number of CPU cores.</description><inventory_link>0</inventory_link><applications><application><name>App Node</name></application></applications><valuemap /><logtimefmt /></item><item><name>Free disk space TEST</name><type>0</type><snmp_community /><multiplier>0</multiplier><snmp_oid /><key>vfs.fs.size[/,pfree]</key><delay>60</delay><history>7</history><trends>365</trends><status>0</status><value_type>0</value_type><allowed_hosts /><units>%</units><delta>0</delta><snmpv3_contextname /><snmpv3_securityname /><snmpv3_securitylevel>0</snmpv3_securitylevel><snmpv3_authprotocol>0</snmpv3_authprotocol><snmpv3_authpassphrase /><snmpv3_privprotocol>0</snmpv3_privprotocol><snmpv3_privpassphrase /><formula>1</formula><delay_flex /><params /><ipmi_sensor /><data_type>0</data_type><authtype>0</authtype><username /><password /><publickey /><privatekey /><port /><description /><inventory_link>0</inventory_link><applications><application><name>App Node</name></application></applications><valuemap /><logtimefmt /></item><item><name>Available memory</name><type>0</type><snmp_community /><multiplier>0</multiplier><snmp_oid /><key>vm.memory.size[available]</key><delay>60</delay><history>7</history><trends>365</trends><status>0</status><value_type>3</value_type><allowed_hosts /><units>B</units><delta>0</delta><snmpv3_contextname /><snmpv3_securityname /><snmpv3_securitylevel>0</snmpv3_securitylevel><snmpv3_authprotocol>0</snmpv3_authprotocol><snmpv3_authpassphrase /><snmpv3_privprotocol>0</snmpv3_privprotocol><snmpv3_privpassphrase /><formula>1</formula><delay_flex /><params /><ipmi_sensor /><data_type>0</data_type><authtype>0</authtype><username /><password /><publickey /><privatekey /><port /><description /><inventory_link>0</inventory_link><applications><application><name>App Node</name></application></applications><valuemap /><logtimefmt /></item></items><discovery_rules /><macros /><templates /><screens><screen><name>MySQL performance</name><hsize>2</hsize><vsize>1</vsize><screen_items /></screen></screens></template></templates><triggers><trigger><expression>{Template App TEAM1:vfs.fs.size[/,pfree].last(0)}&lt;10</expression><name>Disk Usage TEST</name><url /><status>0</status><priority>4</priority><description /><type>0</type><dependencies /></trigger><trigger><expression>{Template App TEAM1:vfs.fs.size[/,pfree].abschange(0)}&gt;10</expression><name>Free Disk Space PREDICT</name><url /><status>0</status><priority>2</priority><description>30s &gt;10%</description><type>0</type><dependencies /></trigger><trigger><expression>{Template App TEAM1:vm.memory.size[available].last(0)}&lt;200M</expression><name>Lack of available memory on server {HOST.NAME}</name><url /><status>0</status><priority>2</priority><description /><type>0</type><dependencies /></trigger><trigger><expression>{Template App TEAM1:system.cpu.load[percpu,avg1].avg(5m)}&gt;2</expression><name>Processor load is too high on {HOST.NAME}</name><url /><status>0</status><priority>2</priority><description /><type>0</type><dependencies /></trigger></triggers><graphs><graph><name>CPU</name><width>900</width><height>200</height><yaxismin>0.0000</yaxismin><yaxismax>100.0000</yaxismax><show_work_period>1</show_work_period><show_triggers>1</show_triggers><type>0</type><show_legend>1</show_legend><show_3d>0</show_3d><percent_left>0.0000</percent_left><percent_right>0.0000</percent_right><ymin_type_1>1</ymin_type_1><ymax_type_1>0</ymax_type_1><ymin_item_1>0</ymin_item_1><ymax_item_1>0</ymax_item_1><graph_items><graph_item><sortorder>0</sortorder><drawtype>0</drawtype><color>F63100</color><yaxisside>0</yaxisside><calc_fnc>2</calc_fnc><type>0</type><item><host>Template App TEAM1</host><key>system.cpu.load[percpu,avg1]</key></item></graph_item></graph_items></graph><graph><name>Disk Usage</name><width>900</width><height>200</height><yaxismin>0.0000</yaxismin><yaxismax>100.0000</yaxismax><show_work_period>1</show_work_period><show_triggers>1</show_triggers><type>0</type><show_legend>1</show_legend><show_3d>0</show_3d><percent_left>0.0000</percent_left><percent_right>0.0000</percent_right><ymin_type_1>1</ymin_type_1><ymax_type_1>1</ymax_type_1><ymin_item_1>0</ymin_item_1><ymax_item_1>0</ymax_item_1><graph_items><graph_item><sortorder>0</sortorder><drawtype>0</drawtype><color>1A7C11</color><yaxisside>0</yaxisside><calc_fnc>2</calc_fnc><type>0</type><item><host>Template App TEAM1</host><key>vfs.fs.size[/,pfree]</key></item></graph_item></graph_items></graph><graph><name>Memory</name><width>900</width><height>200</height><yaxismin>0.0000</yaxismin><yaxismax>100.0000</yaxismax><show_work_period>1</show_work_period><show_triggers>1</show_triggers><type>0</type><show_legend>1</show_legend><show_3d>0</show_3d><percent_left>0.0000</percent_left><percent_right>0.0000</percent_right><ymin_type_1>1</ymin_type_1><ymax_type_1>0</ymax_type_1><ymin_item_1>0</ymin_item_1><ymax_item_1>0</ymax_item_1><graph_items><graph_item><sortorder>0</sortorder><drawtype>0</drawtype><color>1A7C11</color><yaxisside>0</yaxisside><calc_fnc>2</calc_fnc><type>0</type><item><host>Template App TEAM1</host><key>vm.memory.size[available]</key></item></graph_item></graph_items></graph></graphs></zabbix_export>"
)
