#
# Cookbook Name:: xylophone
# Attributes:: default
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

default['xylophone']['nginx']['server_name'] = 'xylophone.teamtreehouse.com'
default['xylophone']['nginx']['log']  = '/var/log/nginx/localhost.access.log'
default['xylophone']['nginx']['root'] = '/srv/xylophone'

default['xylophone']['git_repository'] = 'https://github.com/hortoncd/xylophone-web.git'
default['xylophone']['git_revision']   = '0.1.0'
