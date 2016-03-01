# Munge Cookbook
==========================
[![Build Status](https://travis-ci.org/dmlb2000/munge-cookbook.svg?branch=master)](https://travis-ci.org/dmlb2000/munge-cookbook)

Manage the munge service and keys in a cookbook.

## Usage

```
include_recipe 'munge'
```

### Attributes

Data bag type for the location of the key, supports ```data_bag``` and ```vault```
```
default['munge']['key']['type'] = 'data_bag'
```

Data bag name and item in the data_bag to find the munge key.
```
default['munge']['key']['data_bag'] = 'munge'
default['munge']['key']['item'] = 'key'
```
