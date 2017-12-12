#
# Cookbook Name:: xylophone
# Recipe:: default
#
# Copyright 2017, Chris Horton
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
#

# Disable the default site
node.override['nginx']['default_site_enabled'] = false

include_recipe 'nginx'

directory node['xylophone']['nginx']['root'] do
  owner 'www-data'
  group 'www-data'
  mode '0755'
end

package 'git'

git node['xylophone']['nginx']['root'] do
  repository node['xylophone']['git_repository']
  revision node['xylophone']['git_revision']
  action :sync
end

nginx_site 'xylophone' do
  template 'nginx-xylophone.erb'
end
