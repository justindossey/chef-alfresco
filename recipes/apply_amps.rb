services        = node['alfresco']['system_services']
service_action  = node['alfresco']['system_service_action']

directory "amps-repo" do
  path        node['alfresco']['amps_folder']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

directory "amps-share" do
  path        node['alfresco']['amps_share_folder']
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
  recursive   true
end

template "apply_amps.sh" do
  path        "#{node['alfresco']['bin']}/apply_amps.sh"
  source      "apply_amps.sh.erb"
  owner       node['tomcat']['user']
  group       node['tomcat']['group']
  mode        "0775"
end

execute "run-apply-amps" do
  command "./apply_amps.sh"
  cwd        "#{node['alfresco']['bin']}"
  user        node['tomcat']['user']
  group       node['tomcat']['group']
end

services.each do |serviceName|
  service serviceName  do
    action    service_action
  end
end