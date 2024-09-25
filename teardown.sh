#!/bin/bash

# 1. Remove the OVS ports
ovs-vsctl del-port s1 s1-eth1
ovs-vsctl del-port s1 s1-eth2

# 2. Delete the OVS bridge
ovs-vsctl del-br s1

# 3. Delete the vethernet links
ip link delete s1-eth1
ip link delete s1-eth2

# 4. Delete the namespaces
ip netns delete h1
ip netns delete h2
