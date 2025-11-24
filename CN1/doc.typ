#import "../lib.typ": *
#let lang = "en"
#show: project.with(module: "CN1", name: "Computer Networks 1", semester: "HS25", language: lang)
#let tbl = (..body) => deftbl(lang,..body)

= Application Layer (7,6,5)

Combines Layers 7 (Application), 6 (Presentation) and 5 (Session).

== Common Ports

#table(columns: (auto, auto, auto), table.header([Protocol], [Port], [Layer 4]), 
  [DNS], [ 53 ], [UDP, TCP], 
  [HTTP], [ 80 ], [TCP], 
  [HTTPS], [ 443 ], [TCP], 
  [FTP], [ 20, 21 ], [TCP], 
  [SMTP], [ 25 (server) 587 (client) ], [TCP], 
  [POP3], [ 110 ], [TCP], 
  [DHCP], [ 67 (server) 68 (client) ], [UDP]
)

#[
#set page(flipped:true)

== HTTP

#table(columns: (auto,auto,auto,auto,auto), 
    table.header([Feature],[HTTP/1.0],[HTTP/1.1],[HTTP/2],[HTTP/3]),
    [*Connection Management*]         ,[ One request per connection         ],[ Persistent connections by default     ],[ Multiplexing allows multiple streams                                ],[ Uses QUIC for multiplexing                    ],
    [*Request Methods*]               ,[ Limited (GET, POST, HEAD)          ],[ Enhanced (PUT, DELETE, OPTIONS, etc.) ],[ Same as 1.1                                                         ],[ Same as 1.1                                   ],
    [*Caching*]                       ,[ Basic caching support              ],[ Improved caching with validation      ],[ Advanced caching capabilities                                       ],[ Same as 2 but with improved mechanisms        ],
    [*Header Compression*]            ,[ None                               ],[ None                                  ],[ HPACK (header compression)                                          ],[ QPACK (header compression)                    ],
    [*Server Push*]                   ,[ Not supported                      ],[ Not supported                         ],[ Supported (automatic resource pushing)                              ],[ Enhanced support for server push              ],
    [*Performance Improvements*]      ,[ None                               ],[ Minor improvements over 1.0           ],[ Significant improvements in performance and latency                 ],[ Further improvements in speed and efficiency  ],
    [*SSL/TLS Support*]               ,[ Not inherent                       ],[ Not inherent, but commonly supported  ],[ Built-in support with ALPN (Application-Layer Protocol Negotiation) ],[ Uses QUIC, which incorporates TLS 1.3         ],
    [*Transport Protocol*]            ,[ TCP                                ],[ TCP                                   ],[ TCP                                                                 ],[ QUIC                                          ],
  )
]

== DNS

Nameservers resolve domains to IP's through a distributed, hierarchical database. 
#image("img/dns_hierarchy.png")

#tbl(
  [Iterated query],[Local DNS server iteratively asks one server after the other, descending the domain name hierarchy step after step.],
  [Recursive query], [Local DNS server asks root server for domain, which in turn asks the TLD server, which in turn asks the authoritative server etc. until the "call stack" unwinds and returns the fully resolved domain to the query sender.],
  [Caching],[],
)

=== Record types

#tbl([A], [
  _name_: hostname \
  _value_: IPv4 address
], [AAAA], [
  _name_: hostname \
  _value_: IPv6 address
], [CNAME], [
  _name_: alias \
  _value_: canonical name
], [NS], [
  _name_: domain \
  _value_: hostname of authoritateive NS for this domain
], [MX], [ 
  _name_: domain \
  _value_: name of mailserver
])

== E-Mail

#tbl([ding], [

], [dong], [

], [your], [

], [opinion], [

], [is], [

], [wrong], [

])

= Transport Layer (4)

Segment size: 1440-1480b when using IPv4, <=1460b when using IPv6

== Primary responsibilities

- Process-to-process delivery (distinguish between multiple applications via ports)
- Ensure reliable transfer (acknowledgments, retransmissions & reordering)
- Flow control (sender does not overwhelm receiver)
- Congestion control (network is not overloaded)

#tbl([Port], [
  _16 bit long_ numbers (#dec(0)-#dec(65535)) for identifying applications to send packets to. \
  _Well-Known_: #dec(0)-#dec(1023) for universal TCP/IP applications, managed by the IANA. \
  _Registered_: #dec(1024)-#dec(49151) for known applications, also managed by the IANA. \
  _Private_: #dec(49152)-#dec(65535) for custom applications, not managed by the IANA. \
], [Socket], [
  Combination of _IP:Port_.
], [Multiplexing], [
  Sending data from multiple sockets at sender.
], [Demultiplexing], [
  Delivering segments to correct socket at receiver. 
], [Checksum], [
  Detect errors (i.e., flipped bits) in transmitted segment.
])

== TCP

Connection-oriented, bidirectional, reliable, managed data flow.

#tbl([Handshake], [
  Agreement on *starting sequence numbers*, *maximum segment size* and *window scaling*.
  + SEQ
  + SEQ+ACK
  + ACK
], [FIN], [
  Termination of a connection.
  + FIN
  + FIN+ACK
  + ACK
], [Round Trip Time], [
  _RTT_ is the time it takes for a packet to be sent to the receiver and acknowledged back to the sender.
], [Buffer size], [
  Maximum amount of data (measured in bytes) that can be stored in memory while waiting to be processed or transmitted.
], [Maximum Segment Size], [
  _MSS_ is the maximum payload size of a TCP packet. In IPv4 networks, typically, the size of the MSS is *1460 bytes* because it is encapsulated in the data link layer Ethernet frame size of *1500 bytes*.
])

=== Reliability

#tbl([Sequence numbers], [
  _SEQ_ ensures that the packets arrive or can be reassembled in order. 
], [Acknowledgement], [
  _ACK_ ensures that the receiver gets all of the packets. 
], [Retransmission timeout], [
  If an acknowledgment is not received before the timer for a segment expires, a retransmission timeout occurs, and the segment is *automatically retransmitted*. 
], [Packet loss rate], [
  Measures how many packets of the ones being sent actually arrive.  
])

=== Throughput

#tbl([Throughput], [
  Denoted by _T_, is the amount of data that can be transmitted during a specified time. \
  $T=W/R <= C_(L 3)$
], [Continuous sending], [
  Sender transmits a stream of data packets in the given window size *without waiting for acknowledgments*.
], [Delayed ACK], [
  Receiver waits for a short period to acknowledge *multiple segments* with a *single ACK*.
], [Selective ACK], [
  Instead of asking for a retransmission of all missing segments, _SACK_ (specified by the receiver) allows the sender to send only the lost segments, significantly improving efficiency.
])

=== Flow control

So that the sender does not overwhelm the receiver.

#tbl([Window Size], [
  Denoted by _W_, is a _16 bit_ number sent with each packet by the receiver inside of the *rwnd* header field, indicating the amount of data he still has space for.
], [Window scale], [
  Used when the TCP window size needs to be increased beyond the traditional maximum of 65,535 bytes due to the demands of high-speed networks. \
  If the handshake header includes the *window scale option* and the packet header includes the *scaling factor* then the effective window size is calculated as such: $"window size" * "scaling factor"$
])

=== Congestion control

To prevent network congestion.

#image("./img/congestion_control.jpg")

#tbl(
[Congestion window], [
  #image("./img/cwnd.png")
], [Sliding Window], [
  Describes the process of the congestion window sliding to the right after receiving ACKs.
], [Slow start], [
  Gradual growth (doubling *cwnd* every *RTT*) within the congestion window size at the start of a connection or after a period of state of no activity. \
  _Purpose_: Allows the sender to probe the available bandwidth in a controlled way.
], [Congestion avoidance], [
  Transition from sluggish start to congestion avoidance segment after accomplishing a threshold. \
  _Purpose_: Maintains a truthful share of the community bandwidth even as heading off excessive congestion.
], [Fast Retransmit], [
  Detects packet loss through duplicate acknowledgments and triggers speedy retransmission without waiting for the *retransmission timeout*. \
  _Purpose_: Speeds up the recuperation method with the aid of retransmitting lost packets without looking ahead to a timeout.
], [Fast Recovery], [
  Enters a quick healing state after detecting packet loss, lowering congestion window and transitioning to congestion avoidance. \
  _Purpose_: Accelerates healing from congestion by way of avoiding a complete go back to slow begin after packet loss.
], [AIMD], [
  Adjusts the congestion window size based on network situations following the *Additive Increase, Multiplicative Decrease* principle. \
  _Purpose_: Provides a balanced approach by way of linearly growing the window all through congestion avoidance and halving it on packet loss.
])

== UDP

== QUIC

Actually a layer 7 Protocol, running on top of UDP

= Network Layer (3)

Packet size: *1500b*

== Subnetting 

Dividing a _/X_ network into _n_ amount of _/Y_ subnets: $2^(Y-X) = n$. \
Eg: Dividing a _/16_ network into _/24_ subnets will yield _256_ subnets, because $2^(24-16) = 2^8 = 256$

== IPv6

=== Glossary

#tbl(
[Extension Header],[Additional headers used in IPv6 to provide optional information. These can define aspects like payload size, routing, or fragmentation.],
[DHCPv6],[Dynamic Host Configuration Protocol for IPv6; this allows servers to assign IPv6 addresses dynamically from a pool, similar to DHCP for IPv4.],
[NAT64],[Network Address Translation from IPv6 to IPv4 and vice versa; it facilitates communication between IPv6 and IPv4 networks.],
[Neighbor Discovery \
  Protocol *(NDP)*], [A protocol in IPv6 for discovering other network nodes, determining their link-layer addresses, and ensuring that addresses are valid and reachable.],
[Internet Control Message \
  Protocol *(ICMPv6)*], [A crucial part of IPv6 that handles error messages and operational queries, with an expanded role compared to ICMP in IPv4.],
[MTU],[Maximum Transmission Unit; the size of the largest packet that can be sent in a single frame over a network medium. IPv6 can handle larger MTUs compared to IPv4.],
  [Multicast Listener Discovery *(MLD)*],[IPv6 multicast routers can use MLD to discover multicast listeners on a directly attached link.],
  [Path MTU Discovery *(PMTUD)*],[Protocol for determining the Maximum Transmission Unit (MTU) size on the network path between two hosts, usually with the goal of avoiding IP fragmentation.],
)

=== Special addresses

#tbl(
[Link-local Address],[_FE80::/10_ Used for local communication between devices on the same network segment.],
[Global Unicast Address],[_2000::/3_ A globally routable address, these addresses are equivalent to public IPv4 addresses and can be reached over the internet.],
[Unique Local Address *(ULA)*], [_FC00::/7_ An address for local communication that is not routable on the global internet, similar to private addresses in IPv4.],
[Multicast Address],[_FF00::/8_ An address that enables a single packet to be sent to multiple destinations simultaneously.],
[Anycast Address],[An address assigned to multiple interfaces, where a packet sent to an anycast address is routed to the nearest (in terms of routing distance) interface.],
[Reserved Address],[Certain ranges in IPv6 are reserved for future use or specific functions. For example, addresses starting with _::/128_ are reserved for unspecified addresses.],
[Documentation Address],[_2001:DB8::/32_ Designated specifically for use in documentation and examples, ensuring it does not conflict with real-world addresses.],
[Link-local Multicast Address],[_FF02::/16_ Part of the link-local address range; it enables devices to communicate within a local network without requiring an external routing address.],
)

#table(columns:(auto,auto,auto),
table.header([Addresses],[Range],[Scope]),
[Unspecified],[::/128],[n/a],
[Loopback],[::1],[Host],
[IPv4-Embedded],[64:ff9b::/96],[n/a],
[Discard-Only],[100::/64],[n/a],
[Link-Local],[fe80::/10],[Link],
[Global Unicast],[2000::/3],[Global],
[Unique Local (ULA)],[fc00::/7],[Global],
[Multicast],[ff00::/8],[Variable],
)

==== Multicast

#tbl(
  [ff02::1],[All nodes, within scope 2 (link-local).],
  [ff02::2],[All routers, within scope 2 (link-local).],
  [ff02::1:ffxx:xxxx],[The IPv6 node joins a solicited multicast address group from all the interfaces where unicast and anycast addresses are configured. Its scope is the link-local.]
)

==== DHCPv6

#tbl(
  [ff02::1:2],[A link-scoped multicast address used by a client to communicate with neighboring (i.e., on-link) relay agents and servers. All servers and relay agents are members of this multicast group.],
  [ff05::1:3],[A site-scoped multicast address used by a relay agent to communicate with servers, either because the relay agent wants to send messages to all servers or because it does not know the unicast address of the servers.],
)

=== Header 

#tbl(
  [Version],[Always 6 with IPv6. IPv4 would be 4.],
  [Flow Label],[For identifying packets that require special handling, like real-time streaming.],
  [Traffic Class],[Priority or type of traffic.],
  [Payload Length],[Size of the payload in bytes.],
  [Next Header],[Type of optional header following the IPv6 header.],
  [Hop Limit],[Maximum number of hops a packet can take before being discarded.],
)

==== IPv6 Extension Headers currently defined

#tbl(
[Routing],[Extended routing, like IPv4 loose source route.\
The Routing header is used by an IPv6 source to list one or more intermediate nodes to be "visited" on the way to a packet’s destination. There are different types of routing headers defined for different uses.
],
[Fragmentation],[Fragmentation and reassembly.\
The Fragment header is used by an IPv6 source to send a packet larger than would fit in the path MTU to its destination.
],
[Authentication],[Integrity and authentication, security.\
The Authentication Header (AH) is used by IPsec to provide security services like integrity and data origin authentication to IPv6 traffic.
],
[Encapsulating Security Payload],[Confidentiality.\
Encapsulating Security Payload (ESP) Extension Header [RFC2406(opens in a new tab)] is used by IPsec to provide security services like confidentiality and/or integrity to IPv6 packets. The ESP Extension Header can be followed by an additional Destination Options Extension Header and the upper layer datagram.
],
[Hop-by-Hop Option],[Special options that require hop-by-hop processing.\
The Hop-by-Hop Options header is used to carry optional information that may be examined and processed by every node along a packet's delivery path. The information is included in the form of one or more options using a TLV (Type-Length-Value) format.
],
[Destination Options],[Optional information to be examined by the destination node.\
The Destination Options header is used to carry optional information that is meant to be examined only by a packet's destination node(s). The information is included in the form of one or more options using a TLV (Type-Length-Value) format.
],
)

=== Neighbor Discovery protocol (ND)

==== Host - Router Discovery Functions

#tbl(
[Router discovery],[Hosts can locate routers residing on attached links.],
[Prefix discovery],[Hosts can discover address prefixes that are on-link for attached links.],
[Parameter discovery],[Hosts can find parameters (e.g., MTU).],
[Address autoconfiguration],[Stateless configuration of addresses of network interfaces.],
[Redirect],[Provide a better next-hop route for certain destinations.],
)

==== Host - Host Communication Functions

#tbl(
[Address resolution],[Mapping between IP addresses and link-layer addresses. This is equivalent to ARP for IPv4. This function allows to resolve the link-layer address of another node in the link when only the IPv6 address of that node is known.],
[Next-hop determination],[Hosts can find next-hop routers for a destination.],
[Neighbor unreachability detection (NUD)],[Determine that a neighbor is no longer reachable on the link.],
[Duplicate address detection (DAD)],[Nodes can check whether an address is already in use.],
)

==== Packet types

#table(columns:(auto,auto,auto),
table.header([Name],[Type],[Description]),
[Router Solicitation *(RS)*],[133],[To locate routers on an attached link.],
[Router Advertisement *(RA)*],[134],[Used by routers to advertise their presence periodically or in response to a RS message.],
[Neighbor Solicitation *(NS)*],[135],[To find the MAC-address of the neighbor or to check if the neighbor is still reachable.],
[Neighbor Advertisement *(NA)*],[136],[To respond to a Neighbor Solicitation message.],
[Redirect],[137],[To point the host to a better first hop router for a destination.],
)

=== Stateless Address Autoconfiguration (SLAAC)

A method for automatically configuring IPv6 addresses without a DHCP server, relying on local network information. \

==== Autoconfigure link-local address

Mac address: *70:07:12:34:56:78*
+ Flip *7th* bit: 7#text([2],weight:"bold"):07:12:34:56:78. If it is "0", the address is locally administered and if it is "1", the address is globally unique.
+ Insert *FFEE* in the middle: 7207:12#text([FF:EE],weight:"bold")34:5678
+ Combine with link-local prefix: #text([FE80::],weight:"bold")7207:12FF:EE34:5678
New address: *FE80::7207:12FF:EE34:5678*

==== Perform Duplicate Address Detection (DAD)

To make sure that the address is actually unique in the local segment. \
Upon configuring an IPv6 address, every node joins a *multicast group* identified by the address _FF02::1:FFxx:xxxx_ where xx:xxxx are the *last 6 hexadecimal values* in the IPv6 unicast address, eg. FF02::1:FF#text([34:5678],weight:"bold") \
+ The host sends a Neighbor Solicitation message from the Unspecified Address (::) to the Solicited Node multicast address.
+ If the generated address is in use, the host using that address sends a Neighbor Advertisement back. The sending host then knows the tentative address can not be used.
+ The host then proceeds to generate a new address and sends a new Neighbor Solicitation message to the link.
+ If there is no reply after some time, the host informs all the other hosts that it uses this address and it sends a Neighbor Advertisement message to the All Nodes address.
+ The host assigns the address to the interface and now has an active IPv6 link. This is the so-called Link-local Address Assignment.

==== Router search

+ Router solicitation
+ Router advertisement

==== Generating global unicast address

Based on the information from the Router Advertisement, the host generates a global unicast address and wants to know if it is available to use, so it does the DAD process again. If it is not a duplicate, the host will use it.

=== DHCPv6

==== Flags

#tbl(
[A],[Host can perform SLAAC to generate its own IPv6 address based on the prefix(es) contained in the RA message.],
[O],[Host can fetch additional options from the DHCPv6. The DHCPv6 does not provide IPv6 addresses in this case.],
[M],[Host will get its IP address and additional options from a DHCPv6 server.],
[L],[The prefix shared in the RA is reachable on the link.],
)

== IPv4

=== Network classes (private nets)

#tbl(
  [A],[*10.0.0.0*    - 10.255.255.255  (10_/8_ prefix)],
  [B],[*172.16.0.0*  - 172.31.255.255  (172.16_/12_ prefix)],
  [C],[*192.168.0.0* - 192.168.255.255 (192.168_/16_ prefix)],
)

=== Subnetting

==== Calculating subnet mask

/24 = _1111 1111 . 1111 1111 . 1111 1111 . 0000 0000_ = 255.255.255.0 \
/10 = _1111 1111 . 1100 0000 . 0000 0000 . 0000 0000_ = 255.192.0.0 \

==== Calculating increment

Address increment = $"amount of addresses" / 256$ or $2^(8-("mask" mod 8))$ \
Let there be 4 subsequent networks starting with 10.0.0.0, each being /20 \
Amount of addresses = $2^(32-20)=2^12=4096$. Increment = $4096/256=16$ \
Alternatively: $2^(8-(20 mod 8))=2^(8-4)=2^4=16$ \
Networks = 10.0.*0*.0/20, 10.0.*16*.0/20, 10.0.*32*.0/20, 10.0.*48*.0/20 \

== Routing

- routing table

=== Data plane

- local, per-router function
- determines how datagram arriving on router input port is forwarded to router output port

=== Control plane

- network-wide logic
- determines how datagram is routed among routers along end-to-end path from source to destination host

=== Static

=== Dynamic

==== Algorithms

===== Dijkstra's algorithm (Link State)

===== ? algorithm (Distance vector)

==== Protocols

===== OSPF (Open Shortest Path First)

===== BGP (Border Gateway Protocol)

=== Fragmentation

- offset = transferred bytes / 8

= Data Link Layer (2)

- layer 2 packets change after each intermediary node (switch/router)
- ethernet
  - full duplex / half duplex
  - collision domain
  - CSMA/CD
- switching
  - switch table
  - flooding
  - learning
- vlans
  - forwarding between vlans is done via routing
  - trunk port 
    - carries frames betwween vlans defined over multiple physicas switches
  - frame format
  - spanning tree
    - so that broadcast packets will now continuously loop
    - a switch is selected as root 
    - a tree-like loop-free topology is established
    - bridge protocol data units
      - Hello BPDU
      - Topology Change Notification (TCN) BPDU
      - comparison algorithm


== IEEE 802.3 vs Ethernet II Frame

PDU, MTU

== Error detection

EDC

=== Cyclic Redundancy Check (CRC)

== Mutltiple Access Protocols

== ARP

== Ethernet

= Cisco

== Router setup

```cisco
Router> enable
Router# configure terminal
Router(config)#
```

== Interfaces

=== Static IP Assignment

```cisco
Router(config)# interface GigabetEthernet 0/0/1
Router(config-if)# ip address 172.16.0.0 255.255.255.252
Router(config-if)# no shutdown
Router(config-if)# exit
```

=== DHCP Assignment

```cisco
Router(config)# interface GigabetEthernet 0/1/1
Router(config-if)# ip address dhcp
Router(config-if)# no shutdown
Router(config-if)# exit
```

=== Show

```cisco
Router(config)# do show ip interface brief  
Router# show ip interface brief  
Router# show ip interface GigabetEthernet 0/0/1
```

== VLAN

```cisco
Switch(config)# vlan 120
Switch(config-if)# name vlan-server
Switch(config-if)# exit
```

=== Assign IP

```cisco
Switch(config)# interface vlan 120
Switch(config-if)# ip address 10.120.0.10 255.255.255.0
```

=== Access Port

```cisco
Switch(config)# interface GigabitEthernet 0/0/1
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 120
Switch(config-if)# exit
Switch(config)# interface GigabitEthernet 0/0/1-5
Switch(config-if)# switchport mode access
Switch(config-if)# switchport access vlan 120
Switch(config-if)# exit
```

=== Access Port

```cisco
Switch(config-if)# switchport mode trunk
```

=== VTP (Virtual Trunk Protocol)

==== Server

```cisco
Switch(config)# vtp domain ins
Switch(config)# vtp mode server
```

==== Client

```cisco
Switch(config)# vtp domain ins
Switch(config)# vtp mode client
```

=== LACP (Link Aggregation Control Protocol)

```cisco
Switch(config-if)# channel-group 5 mode active
Switch(config-if)# channel-group 5 mode passive
```

=== Load Balancing

```cisco
Switch(config)# port-channel load-balance <strategy>
```

=== STP (Spanning Tree Protocol)

==== Bridge priority

```cisco
Switch(config)# spanning-tree vlan 1 priority <priority>
```

==== Interface costs

```cisco
Switch(config-if)# spanning-tree cost 100
```

==== PortFast mode

```cisco
Switch(config-if)# spanning-tree portfast
```

==== Show

```cisco
Switch# show spanning-tree
Switch# show spanning-tree root
```

== Routing

=== Static

==== IPv4

```cisco
Router(config-if)# ip route <destination_network_id> <subnet_mask> <next_hop_router> <adminitrative_distance>?
Router(config-if)# ip route 10.0.0.0 255.0.0.0 192.168.1.1
```

==== IPv6

```cisco
Router(config-if)# ip route <ipv6_prefix> <outgoing_interface> <next-hop> <administrative_distance>?
Router(config-if)# ipv6 route 2001:db8:2103:a::/64 GigabitEthernet1/0/1 fe80::ba27:ebff:fea8:3e50
```

=== OSPF

==== IPv4

```cisco
Router(config)# router ospf <process-id>
Router(config-if)# ip ospf <process-id> area <area-nr>
```

==== IPv6

```cisco
Router(config)# ipv6 router ospf <process-id>
Router(config-if)# ipv6 ospf <process-id> area <area-nr>
```

=== Show

```cisco
Router# show ip route
Router# show ip ospf route
```

== DHCP

=== Create Pool

```cisco
Router#(config-if) ip dhcp pool DEV
 network 192.168.1.0 255.255.255.0
 default-router 192.168.1.1
 dns-server 1.1.1.1 8.8.8.8
 lease 5
 domain-name enterprise.com
```

=== Relay Agent

```cisco
Router(config-if)# ip helper-address 176.16.12.10
```

== NAT

=== IF Inside

```cisco
Router(config-if)# ip nat inside
```

=== IF Outside

```cisco
Router(config-if)# ip nat outside
```

=== ACL (Access Control List)

```cisco
Router(config-if)# access-list 1 permit 192.168.1.0 0.0.0.255
```

=== PAT (Nat overload)

```cisco
Router(config-if)# ip nat inside source list 1 interface GigabitEthernet0/1 overload
```

== IPv6

```cisco
Router(config-if)# ipv6 enable
```

=== DHCPv6

```cisco
Router(config-if)# ipv6 dhcp client pd MY_PREFIX
Router(config-if)# ipv6 address autoconfig default
```

== Troubleshooting

=== Ping

```cisco
Router# ping <destination-ip> source <interface-name>
```

=== Traceroute

```cisco
Router# traceroute <destination-ip> source <interface-name> numeric
```

= Binary, Decimal, Hex

#hex(42090) = #bin(42090) = #dec(42090) \
#hex(1200) = #bin(1200) = #dec(1200) \
#hex(120000) = #bin(120000) = #dec(120000)
