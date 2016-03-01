#
# Cookbook Name:: munge
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'munge::default' do
  context 'When all attributes are default, on an unspecified platform' do
    before do
      Chef::EncryptedDataBagItem.stub(:load).with('munge', 'key').and_return(
        mungekey: 'aRz24Kt4tAt2Fb5R1m3iqSNNpxFZKBsySWVMxM2phOc=',
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
