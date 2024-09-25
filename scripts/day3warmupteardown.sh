#!/bin/bash

# Delete the Open vSwitch bridge, send errors to /dev/null
sudo ovs-vsctl del-br vlan-bridge &> /dev/null

# Delete the network namespaces, send errors to /dev/null
sudo ip netns del host1 &> /dev/null
sudo ip netns del host2 &> /dev/null
