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
[Neighbor Solicitation],[],
[Router Advertisement *(RA)*], [A message sent by routers to announce their presence along with various link parameters.],
[Router Solicitation *(RS)*], [A message sent by hosts to request additional information from routers.],
[Internet Control Message \
  Protocol *(ICMPv6)*], [A crucial part of IPv6 that handles error messages and operational queries, with an expanded role compared to ICMP in IPv4.],
[MTU],[Maximum Transmission Unit; the size of the largest packet that can be sent in a single frame over a network medium. IPv6 can handle larger MTUs compared to IPv4.],
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

=== Header 

#tbl(
  [Version],[Always 6 with IPv6. IPv4 would be 4.],
  [Flow Label],[For identifying packets that require special handling, like real-time streaming.],
  [Traffic Class],[Priority or type of traffic.],
  [Payload Length],[Size of the payload in bytes.],
  [Next Header],[Type of optional header following the IPv6 header.],
  [Hop Limit],[Maximum number of hops a packet can take before being discarded.],
)

=== Stateless Address Autoconfiguration (SLAAC)

A method for automatically configuring IPv6 addresses without a DHCP server, relying on local network information. \

==== Autoconfigure link-local address

Mac address: *70:07:12:34:56:78*
+ Flip *7th* bit: 7#text([2],weight:"bold"):07:12:34:56:78
+ Insert *FFEE* in the middle: 7207:12#text([FF:EE],weight:"bold")34:5678
+ Combine with link-local prefix: #text([FE80::],weight:"bold")7207:12FF:EE34:5678
New address: *FE80::7207:12FF:EE34:5678*

==== Perform Duplicate Address Detection (DAD)

To make sure that the address is actually unique in the local segment. \
Upon configuring an IPv6 address, every node joins a *multicast group* identified by the address _FF02::1:FFxx:xxxx_ where xx:xxxx are the *last 6 hexadecimal values* in the IPv6 unicast address, eg. FF02::1:FF#text([34:5678],weight:"bold") \

==== #corr([TBD...])

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

= Binary, Decimal, Hex

#hex(42090) = #bin(42090) = #dec(42090) \
#hex(1200) = #bin(1200) = #dec(1200) \
#hex(120000) = #bin(120000) = #dec(120000)
