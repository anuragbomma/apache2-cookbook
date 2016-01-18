#
# Cookbook Name:: apache2
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "apache2" do
	action :install
end

node["apache2"]["sites"].each do |sitename, data|
  document_root = "/content/sites/#{sitename}"

  directory document_root do
	mode "0755"
        recursive true
  end

template "/etc/apache2/conf.d/#{sitename}.conf" do
       source "vhost.erb"
       mode "0644"
       variables(
		:document_root => document_root,
		:port  => data["port"],
		:domain => data["domain"]
       )
       notifies :restart, "service[apache2]"
  end

template  "/content/sites/#{sitename}/index.html" do
	source "index.html.erb"
	mode "0644"
	variables(
                :site_title => data["site_title"],
                :comingsoon => "comingsoon!"
        )
end

end

execute "/etc/apache2/conf.d/other-vhosts-access-log" do
	only_if do
		File.exists?("/etc/apache2/conf.d/other-vhosts-access-log")
	end
	notifies :restart, "service[apache2]"
end

service "apache2" do
	action [:enable, :start]
end

execute 'yum update' do
  command 'yum update -y'
end	

include_recipe "php5::default"
