#
# Cookbook Name:: munge
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

case node[:platform_family]
when 'debian'
  include_recipe 'apt'
when 'rhel'
  include_recipe 'yum-epel'
end

user 'munge'
group 'munge'

package 'munge'

data_bag = node['munge']['key']['data_bag']
item = node['munge']['key']['item']
data_bag_secret = Chef::Config['encrypted_data_bag_secret']

case node['munge']['key']['type']
when 'data_bag'
  secret_key = Chef::EncryptedDataBagItem.load_secret(data_bag_secret)
  key_item = Chef::EncryptedDataBagItem.load(data_bag, item, secret_key)
when 'vault'
  chef_gem 'chef-vault'
  require 'chef-vault'
  key_item = chef_vault_item(data_bag, item)
end

template 'mungekey.ascii' do
  user 'munge'
  group 'munge'
  mode "0400"
  path '/etc/munge/munge.key.base64'
  notifies :run, 'bash[create-munge-key]'
  source 'mungekey.erb'
  variables({
    :data => key_hash['mungekey']
  })
end

bash 'create-munge-key' do
  user 'root'
  cwd '/tmp'
  code 'base64 -d < /etc/munge/munge.key.base64 > /etc/munge/munge.key'
  action :nothing
end

file 'mungekey' do
  user 'munge'
  group 'munge'
  mode '0400'
  path '/etc/munge/munge.key'
end

service 'munge' do
  service_name 'munge'
  supports [:enable, :start, :restart, :status, :stop]
  subscribes :restart, 'bash[create-munge-key]', :immediately
  action :enable
end
