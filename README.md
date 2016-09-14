# Munge Cookbook
==========================
[![Build Status](https://travis-ci.org/dmlb2000/munge-cookbook.svg?branch=master)](https://travis-ci.org/EMSL-MSC/munge-cookbook)

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

### Encrypted Data Bags

To create a chef encrypted data bag follow the instructions by Atomic Penguin
[1](http://atomic-penguin.github.io/blog/2013/06/07/HOWTO-test-kitchen-and-encrypted-data-bags/)

# Contributions
=====================

1. fork it on github
2. make a merge request
3. we'll talk about it

