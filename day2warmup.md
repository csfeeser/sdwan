
# **Warmup: Network Namespaces and VETH!**

```
+-----------------------+       +-----------------------+
|    Namespace: zelda    |      |  Namespace: ganondorf |
|  +-----------------+   |      |  +-----------------+  |
|  |  Interface:      |  |      |  |  Interface:      | |
|  |  zelda2ganondorf |  |      |  |  ganondorf2zelda | |
|  +-----------------+   |      |  +-----------------+  |
+-----------------------+       +-----------------------+
          |                                   |
          |                                   |
     +---------------------------------------------+
     |              Virtual Ethernet (VETH)        |
     +---------------------------------------------+
```

Welcome to your **Warmup Challenge**! Your mission is to:

1. Create two network namespaces: `zelda` and `ganondorf`.
2. Establish a virtual Ethernet (VETH) connection between the two namespaces.
3. Ensure they can communicate with each other using `ping`.

### The Goal

In this challenge, you’ll create a network similar to the diagram above. The two network namespaces, `zelda` and `ganondorf`, will be connected via a virtual Ethernet pair (`zelda2ganondorf` and `ganondorf2zelda`). Your task is to set up this connection and ensure that `zelda` and `ganondorf` can ping each other.

---

### 👀 Hints (For When You Need a Gentle Nudge)

<details>
  <summary>Need a few hints? Click here to reveal!</summary>

  - You’ll need to create a pair of VETH interfaces and assign one to each namespace.
  - Ensure the loopback interfaces are up in both namespaces.
  - Use the `ip netns exec` command to run commands inside namespaces.

</details>

---

### 🛠️ Solution (Spoilers Ahead!)

<details>
<summary>Click here if you want the full solution!</summary>

- Make sure to bring up both interfaces and assign proper IPs to them.
- Don’t forget to bring up the loopback interface in each namespace.

Here’s the solution:

```bash
    sudo ip netns add zelda
    sudo ip netns add ganondorf
    sudo ip link add zelda2ganondorf type veth peer name ganondorf2zelda
    sudo ip link set zelda2ganondorf netns zelda
    sudo ip link set ganondorf2zelda netns ganondorf
    sudo ip netns exec zelda ip addr add 192.168.1.1/24 dev zelda2ganondorf
    sudo ip netns exec ganondorf ip addr add 192.168.1.2/24 dev ganondorf2zelda
    sudo ip netns exec zelda ip link set dev zelda2ganondorf up
    sudo ip netns exec ganondorf ip link set dev ganondorf2zelda up
    sudo ip netns exec zelda ip link set dev lo up
    sudo ip netns exec ganondorf ip link set dev lo up
    sudo ip netns exec zelda ping 192.168.1.2
```

  This will successfully connect the two namespaces and allow them to communicate via `ping`.
</details>
