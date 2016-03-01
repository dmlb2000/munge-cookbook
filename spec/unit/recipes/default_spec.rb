#
# Cookbook Name:: munge
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'munge::default' do
  context 'When all attributes are default, on an unspecified platform' do
    before do
      Chef::Config['encrypted_data_bag_secret'] = '/tmp/secretfile'
      Chef::EncryptedDataBagItem.stub(:load_secret)
                                .with('/tmp/secretfile')
                                .and_return('secret')
      Chef::EncryptedDataBagItem.stub(:load)
                                .with('munge', 'key', 'secret')
                                .and_return(
                                  mungekey: 'bbwikV9x/bMmaT81rCaQiw=='
                                )
    end
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
