#
# Cookbook Name:: xylophone
# Spec:: default
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

require 'spec_helper'

describe 'xylophone::default' do
  versions = %w{14.04 16.04}
  versions.each do |v|
    context 'When all attributes are default, on a ubuntu platform' do
      let(:chef_run) { ChefSpec::SoloRunner.new(platform: 'ubuntu', version: v).converge(described_recipe) }

      it 'converges successfully' do
        expect { chef_run }.to_not raise_error
      end

      %w{ git nginx }.each do |p|
        it "installs #{p}" do
          expect(chef_run).to install_package(p)
        end
      end

      it 'creates a app directory' do
        expect(chef_run).to create_directory('/srv/xylophone').with(
          user: 'www-data',
          group: 'www-data',
        )
      end

      it 'syncs the app from git' do
        expect(chef_run).to sync_git('/srv/xylophone')
      end

      it 'includes nginx recipe' do
        expect(chef_run).to include_recipe('nginx')
      end

      it 'sets up nginx' do
        expect(chef_run).to enable_nginx_site('xylophone')
        expect(chef_run).not_to enable_nginx_site('default')
      end
    end
  end
end
