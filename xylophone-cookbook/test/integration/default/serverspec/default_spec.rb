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
  %w{ git nginx }.each do |p|
    describe package(p) do
      it { should be_installed }
    end
  end

  describe file('/etc/nginx/sites-available/xylophone') do
    it { should be_file }
    it { should be_mode '644' }
    its(:content) { should match %r{xylophone.teamtreehouse.com} }
  end

  describe file('/etc/nginx/sites-enabled/xylophone') do
    it { should be_symlink }
    it { should be_linked_to '/etc/nginx/sites-available/xylophone' }
  end

  describe file('/srv/xylophone') do
    it { should be_directory }
    it { should be_owned_by 'www-data' }
    it { should be_grouped_into 'www-data' }
    it { should be_mode '755' }
  end

  # simple check that git checkout 'worked'
  describe file('/srv/xylophone/.git') do
    it { should be_directory }
  end

  describe service('nginx') do
    it { should be_enabled }
    it { should be_running }
  end

  describe command('wget http://localhost/') do
    its('exit_status') { should eq 0 }
  end
end
