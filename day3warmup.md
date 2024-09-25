# **Warmup: VLAN Setup with Issues!**

<img src="https://media.makeameme.org/created/well-just-go-ecb32b4353.jpg" alt="networking-meme" width="300"/>

Welcome to your **Warmup Challenge!** There’s a twist in this one: your job is to troubleshoot and fix three problems in the provided bash script. You’ll set up a VLAN with two hosts and a bridge, but the script has some intentional issues that you’ll need to identify and fix.

1. First, you need to create a bash script that sets up your VLAN. Open a file using `vim` and copy the script below:

    `student@bchd:~$` `vim vlan-setup.sh`

    ```bash
    #!/bin/bash
    
    # Create an Open vSwitch bridge
    sudo ovs-vsctl add-br vlan-bridge
    
    # Create two network namespaces (hosts)
    sudo ip netns add host1
    sudo ip netns add host2
    
    # Create internal ports (interfaces) on the bridge for each host
    sudo ovs-vsctl add-port vlan-bridge vlan-host1 -- set interface vlan-host1 type=internal
    sudo ovs-vsctl add-port vlan-bridge vlan-host2 -- set interface vlan-host2 type=internal
    
    # Assign the created interfaces to the namespaces
    sudo ip link set vlan-host1 netns host1
    sudo ip link set vlan-host2 netns host2
    
    # Bring the interfaces up inside each namespace
    sudo ip netns exec host1 ip link set dev vlan-host1 up
    sudo ip netns exec host2 ip link set dev vlan-host2 up
    
    # Set the loopback interfaces up for each namespace
    sudo ip netns exec host1 ip link set lo up
    sudo ip netns exec host2 ip link set lo up
    
    # Assign IP address
    sudo ip netns exec host1 ip addr add 192.168.10.1/24 dev vlan-host1

    # Start DHCP on host2
    sudo ip netns exec host2 dnsmasq --interface=vlan-host2 --dhcp-range=192.168.20.2,192.168.20.10,255.255.255.0
    ```

2. Run the script to set up your VLAN and hosts. THIS WILL FAIL AS WRITTEN.

    `student@bchd:~$` `bash vlan-setup.sh`

3. Once the script finishes running, use `ping` to test if `host1` can reach `host2`. If everything were correct, this command would work, but due to the errors, it will fail.

    `student@bchd:~$` `sudo ip netns exec host1 ping 192.168.10.2`

4. When you want to reset the lab (or are finished and are ready to clean up) run the following command:

    `student@bchd:~$` `wget -q -O teardown.sh https://raw.githubusercontent.com/csfeeser/sdwan/refs/heads/main/scripts/day3teardownnew.sh && bash teardown.sh`

### 👀 Hints/Solutions

Click the dropdowns for a basic hint. Each will reveal more specific hints, leading to the solution if needed!

<details>
<summary>Initial hint: Issue with IP Address Assignment on host2</summary>

  <details>
  <summary>More specific hint: An IP address should be assigned to the interface for `host2`.</summary>

  <details>
  <summary>Even more specific hint: Try manually assigning an IP for `host2`.</summary>

  <details>
  <summary>CLICK HERE FOR THE SOLUTION!</summary>

  ```bash
  sudo ip netns exec host2 ip addr add 192.168.10.2/24 dev vlan-host2
  ```

  </details>
  </details>
  </details>
</details>

---

<details>
  <summary>Initial hint:Issue with DHCP Subnet</summary>

  <details>
  <summary>More specific hint: `host1` and `host2` should be in the same subnet (192.168.10.x).</summary>

  <details>
  <summary>Even more specific hint: Correct the subnet used by the DHCP server on `host2`.</summary>

  <details>
  <summary>CLICK HERE FOR THE SOLUTION!</summary>

  ```bash
  sudo ip netns exec host2 dnsmasq --interface=vlan-host2 --dhcp-range=192.168.10.2,192.168.10.10,255.255.255.0
  ```

  </details>
  </details>
  </details>
</details>

---

<details>
<summary>Initial hint: Connectivity Issue</summary>

  <details>
  <summary>More specific hint: Verify the IP addresses and ensure both interfaces are up.</summary>

  <details>
  <summary>Even more specific hint: Use `ping` to test connectivity after fixing the IP issue.</summary>

  <details>
  <summary>CLICK HERE FOR THE SOLUTION!</summary>

  ```bash
  sudo ip netns exec host1 ping 192.168.10.2
  ```

  </details>
  </details>
  </details>
</details>
