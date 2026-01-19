#import "../lib.typ": *
#import "@preview/chronos:0.2.1" as chronos: _seq
#import fletcher.shapes: diamond, hexagon, parallelogram, pill
#show: project.with(
  module: "CN1",
  name: "Computer Networks 1",
  semester: "HS25",
  language: "en",
)

#[
  #set page(flipped: true)

  = Application Layer (7,6,5)

  Combines Layers 7 (Application), 6 (Presentation) and 5 (Session).

  == HTTP

  #table(
    columns: (auto, auto, auto, auto, auto),
    table.header([Feature], [HTTP/1.0], [HTTP/1.1], [HTTP/2], [HTTP/3]),
    [*Connection Management*],
    [ One request per connection ],
    [ Persistent connections by default ],
    [ Multiplexing allows multiple streams],
    [ Uses QUIC for multiplexing],

    [*Request Methods*],
    [ Limited (GET, POST, HEAD)],
    [ Enhanced (PUT, DELETE, OPTIONS, etc.) ],
    [ Same as 1.1 ],
    [ Same as 1.1 ],

    [*Caching*],
    [ Basic caching support],
    [ Improved caching with validation],
    [ Advanced caching capabilities ],
    [ Same as 2 but with improved mechanisms],

    [*Header Compression*],
    [ None ],
    [ None],
    [ HPACK (header compression)],
    [ QPACK (header compression)],

    [*Server Push*],
    [ Not supported],
    [ Not supported ],
    [ Supported (automatic resource pushing)],
    [ Enhanced support for server push],

    [*Performance Improvements*],
    [ None ],
    [ Minor improvements over 1.0 ],
    [ Significant improvements in performance and latency ],
    [ Further improvements in speed and efficiency],

    [*SSL/TLS Support*],
    [ Not inherent ],
    [ Not inherent, but commonly supported],
    [ Built-in support with ALPN (Application-Layer Protocol Negotiation) ],
    [ Uses QUIC, which incorporates TLS 1.3 ],

    [*Transport Protocol*], [ TCP], [ TCP ], [ TCP ], [ QUIC],
  )
]

== Common Ports

#table(
  columns: (1fr, 1fr, 1fr),
  table.header([Protocol], [Port], [Layer 4]),
  [DNS], [ 53 ], [UDP, TCP],
  [HTTP], [ 80 ], [TCP],
  [HTTPS], [ 443 ], [TCP],
  [FTP], [ 20, 21 ], [TCP],
  [SMTP], [ 25 (server) 587 (client) ], [TCP],
  [POP3], [ 110 ], [TCP],
  [DHCP], [ 67 (server) 68 (client) ], [UDP],
)

== DNS

Nameservers resolve domains to IP's through a distributed, hierarchical database.

#let dtr = t => text(weight: "bold", fill: colors.red, t)

#diagram(
  node-stroke: none,
  spacing: (0em, 1em),
  node((5, 0), dtr("Root")),
  node((5, 1), dtr("Top Level Domain")),
  node((5, 2), dtr("Authoritative")),

  node((2, 0), "Root DNS Servers", name: <root>),

  node((0.5, 1), ".com DNS Servers", name: <com>),
  node((2, 1), ".org DNS Servers", name: <org>),
  node((3.5, 1), ".edu DNS Servers", name: <edu>),

  node((0, 2), [yahoo.com\ DNS Servers], name: <yahoo>),
  node((1, 2), [amazon.com\ DNS Servers], name: <amazon>),
  node((2, 2), [pbs.org\ DNS Servers], name: <pbs>),
  node((3, 2), [nyu.edu\ DNS Servers], name: <nyu>),
  node((4, 2), [umass.edu\ DNS Servers], name: <umass>),

  edge(<root>, <com>, "-|>"),
  edge(<root>, <org>, "-|>"),
  edge(<root>, <edu>, "-|>"),

  edge(<com>, <yahoo>, "-|>"),
  edge(<com>, <amazon>, "-|>"),
  edge(<org>, <pbs>, "-|>"),
  edge(<edu>, <nyu>, "-|>"),
  edge(<edu>, <umass>, "-|>"),
)

#deftbl(
  [Iterated query],
  [Local DNS server iteratively asks one server after the other, descending the domain name hierarchy step after step.],
  [Recursive query],
  [Local DNS server asks root server for domain, which in turn asks the TLD server, which in turn asks the authoritative server etc. until the "call stack" unwinds and returns the fully resolved domain to the query sender.],
  [Caching],
  [Client-side temporary storage of DNS lookup information.],
)

=== Record types

#table(
  columns: (1fr, 1fr, 1fr),
  "Type", "Name", "Value",
  [A], [ hostname ], [ IPv4 address],
  [AAAA], [ hostname ], [ IPv6 address ],
  [CNAME], [ alias ], [ canonical name ],
  [NS], [ domain ], [ hostname of authoritateive NS for this domain ],
  [MX], [ domain ], [ name of mailserver ],
  [PTR], [ IP ], [ domain ],
)

== E-Mail

#deftbl(
  [SMTP (Simple Mail \ Transfer Protocol)],
  [Used to send email messages from a client to a mail server or between mail servers],
  [IMAP (Internet Message \ Access Protocol)],
  [Synchronizes email across multiple devices without downloading them],
  [POP3 (Post Office \ Protocol version 3)],
  [Downloads email messages onto the user's local device, often removing them from the server afterward],
  [MIME (Multipurpose \ Internet Mail Extensions)],
  [An extension of the Internet email protocol that allows multimedia content to be transmitted via email],
  [SPF (Sender Policy \ Framework)],
  [An email authentication method that helps prevent spoofing],
  [MUA (Mail User Agent)],
  [Allows users to send, receive, and organize their emails (eg. Mozilla Thunderbird)],
  [MTA (Mail Transfer Agent)],
  [Transfers email messages between servers (eg. Postfix)],
  [MDA (Mail Delivery Agent)],
  [Processes incoming messages from the MTA and places them in the user's mailbox],
)

= Transport Layer (4)

Segment size: 1440-1480b when using IPv4, <=1460b when using IPv6

== Primary responsibilities

- Process-to-process delivery (distinguish between multiple applications via ports)
- Ensure reliable transfer (acknowledgments, retransmissions & reordering)
- Flow control (sender does not overwhelm receiver)
- Congestion control (network is not overloaded)

#deftbl(
  [Port],
  [
    _16 bit long_ numbers (*0-65535*) for identifying applications to send packets to. \
    _Well-Known_: *0-1023* for universal TCP/IP applications, managed by the IANA. \
    _Registered_: *1024-49151* for known applications, also managed by the IANA. \
    _Private_: *49152-65535* for custom applications, not managed by the IANA. \
  ],
  [Socket],
  [
    Combination of _IP:Port_.
  ],
  [Multiplexing],
  [ Sending data from multiple sockets at sender. ],
  [Demultiplexing],
  [ Delivering segments to correct socket at receiver. ],
  [Checksum],
  [
    Detect errors (i.e., flipped bits) in transmitted segment.
  ],
)

== TCP

Connection-oriented, bidirectional, reliable, managed data flow.

#frame(
  ("Source Port": 16, "Destination Port": 16),
  ("Sequence Number": 16, "Acknowledgement Number": 16),
  (
    "Offset": 4,
    "Reserved": 6,
    "U R G": (desc: "Urgent Pointer", size: 1),
    "A C K": (desc: "Acknowledgement flag", size: 1),
    "P S H": (desc: "Push flag", size: 1),
    "R S T": (desc: "Reset flag", size: 1),
    "S Y N": (desc: "synchronize flag", size: 1),
    "F I N": (desc: "Finish flag", size: 1),
    "Window Size": (desc: "Sender's receive window", size: 16),
  ),
  ("Checksum": 16, "Urgent Pointer": 16),
  (
    "Options": (desc: "Variable length. MSS, Window scaling, etc.", size: 24),
    "Padding": (desc: "Variable length", size: 8),
  ),
  ("Data": (desc: "Variable length", size: 32)),
)

=== Glossary

#grid(
  columns: (auto, 1fr),
  [
    \
    #chronos.diagram({
      _par("Client")
      _par("Server")

      _seq("Client", "Server", comment: "SYN")
      _seq("Server", "Client", dashed: true, comment: "SYN+ACK")
      _seq("Client", "Server", dashed: true, comment: "ACK")

      _seq("Client", "Server", comment: "SEQ (1)")
      _seq("Server", "Client", dashed: true, comment: "ACK (2)")
      _seq("Client", "Server", comment: "SEQ (2)")
      _seq("Server", "Client", dashed: true, comment: "ACK (3)")

      _seq("Client", "Server", comment: "FIN")
      _seq("Server", "Client", dashed: true, comment: "ACK")
      _seq("Server", "Client", comment: "FIN")
      _seq("Client", "Server", dashed: true, comment: "ACK")
    })],
  deftbl(
    [Handshake],
    [
      Agreement on *starting sequence numbers*, *maximum segment size* and *window scaling*.
      + SYN
      + SYN+ACK
      + ACK
    ],
    [FIN],
    [
      Termination of a connection.
      + FIN
      + ACK
      + FIN
      + ACK
    ],
    [Round Trip Time],
    [
      _RTT_ is the time it takes for a packet to be sent to the receiver and acknowledged back to the sender.
    ],
    [Buffer size],
    [
      Maximum amount of data (measured in bytes) that can be stored in memory while waiting to be processed or transmitted.
    ],
    [Maximum Segment Size],
    [ _MSS_ is the maximum payload size of a TCP packet. In IPv4 networks, typically, the size of the MSS is *1460 bytes* because it is encapsulated in the data link layer Ethernet frame size of *1500 bytes*. -(20 bytes for IP header + 20 bytes for TCP header)],
  ),
)

=== Reliability

#deftbl(
  [Sequence numbers],
  [
    _SEQ_ ensures that the packets arrive or can be reassembled in order.
  ],
  [Acknowledgement],
  [
    _ACK_ ensures that the receiver gets all of the packets.
  ],
  [Retransmission timeout],
  [ If an acknowledgment is not received before the timer for a segment expires, a retransmission timeout occurs, and the segment is *automatically retransmitted*. ],
  [Packet loss rate],
  [
    Measures how many packets of the ones being sent actually arrive.
  ],
  [Duplicate ACKs],
  [A duplicate ACK occurs when a receiver receives a segment of data that is not the next expected segment, prompting it to send back the *same acknowledgment* of the *last correctly received* packet multiple times. This signals to the sender that some packets might be lost or that the data is arriving out of order.],
  [Triple Duplicate ACKs],
  [A triple duplicate ACK specifically refers to the situation where the receiver sends *three duplicate ACKs* in a row for the same segment. This particular signal indicates to the sender that a packet has likely been lost. In response, TCP will trigger a *fast retransmission* of the missing packet without waiting for a timeout.],
)

=== Throughput

#deftbl(
  [Throughput],
  [
    Denoted by _T_, is the amount of data that can be transmitted during a specified time. \
    $T=W/R <= C_(L 3)$
  ],
  [Continuous sending],
  [
    Sender transmits a stream of data packets in the given window size *without waiting for acknowledgments*.
  ],
  [Delayed /\ Cumulative ACK],
  [
    Receiver waits for a short period to acknowledge *multiple segments* with a *single ACK*.
  ],
  [Selective ACK],
  [
    Instead of asking for a retransmission of all missing segments, _SACK_ (specified by the receiver) allows the sender to send only the lost segments, significantly improving efficiency.
  ],
)

=== Flow control

So that the sender does not _overwhelm the receiver_.

#deftbl(
  [Window Size],
  [
    Denoted by _W_, is a _16 bit_ number sent with each packet by the receiver inside of the *rwnd* header field, indicating the amount of data he still has space for. If sender receives a window size of 0, it starts a persistence timer. When the persistence timer goes off, the sending TCP sends a special segment called a window probe to query the receiver periodically and find out if the window has been increased.
  ],
  [Window scale],
  [
    Used when the TCP window size needs to be increased beyond the traditional maximum of 65,535 bytes due to the demands of high-speed networks. \
    If the handshake header includes the *window scale option* and the packet header includes the *scaling factor* (max value of 14) then the effective window size is calculated as such: $"window size" * 2^"scaling factor"$
  ],
  [Receiver Window],
  [Managed by the receiver, who sends out window sizes to the sender. The window sizes announce the number of *bytes still free* in the receiver buffer],
)


=== Congestion control

To prevent _network congestion_.

#image("./img/congestion_control.jpg")

#deftbl(
  [Congestion window],
  [
    #image("./img/cwnd.png")
  ],
  [Sliding Window],
  [
    Describes the process of the congestion window sliding to the right after receiving ACKs.
  ],
  [Slow start],
  [
    Gradual growth (doubling *cwnd* every *RTT*) within the congestion window size at the start of a connection or after a period of state of no activity. \
    _Purpose_: Allows the sender to probe the available bandwidth in a controlled way.
  ],
  [Congestion avoidance],
  [
    Transition from sluggish start to congestion avoidance segment after accomplishing a threshold. \
    _Purpose_: Maintains a truthful share of the community bandwidth even as heading off excessive congestion.
  ],
  [Fast Retransmit],
  [
    Detects packet loss through duplicate acknowledgments and triggers speedy retransmission without waiting for the *retransmission timeout*. \
    _Purpose_: Speeds up the recuperation method with the aid of retransmitting lost packets without looking ahead to a timeout.
  ],
  [Fast Recovery],
  [
    Enters a quick healing state after detecting packet loss, lowering congestion window and transitioning to congestion avoidance. \
    _Purpose_: Accelerates healing from congestion by way of avoiding a complete go back to slow begin after packet loss.
  ],
  [AIMD],
  [
    Adjusts the congestion window size based on network situations following the *Additive Increase, Multiplicative Decrease* principle. \
    _Purpose_: Provides a balanced approach by way of linearly growing the window all through congestion avoidance and halving it on packet loss.
  ],
)

== UDP

#frame(
  ("Source Port": 16, "Destination Port": 16),
  (Length: 16, Checksum: 16),
  (Data: 32),
)

== QUIC

Actually a layer 7 Protocol, running on top of UDP

= Network Layer (3)

Packet size: *1500b*

== Subnetting

Dividing a _/X_ network into _n_ amount of _/Y_ subnets: $2^(Y-X) = n$. \
Eg: Dividing a _/16_ network into _/24_ subnets will yield _256_ subnets, because $2^(24-16) = 2^8 = 256$

== IPv6

=== Header

#frame(
  (
    "Version": (desc: "Version of IP Protocol (always 6)", size: 4),
    "Traffic class": (
      desc: "Priority + Class. Used for differentiating level of service and packet types",
      size: 8,
    ),
    "Flow label": (
      desc: "Used to identify packets belonging to the same flow",
      size: 20,
    ),
  ),
  (
    "Payload length": (
      desc: "Size of the data payload in bytes that follows the IPv6 header. max is 65'535 bytes",
      size: 16,
    ),
    "Next header": (
      desc: "Type of optional header following the IPv6 header.",
      size: 8,
    ),
    "Hop limit": (
      desc: "Maximum number of hops a packet can take before being discarded.",
      size: 8,
    ),
  ),
  ("Source address (128 bits)": 32),
  ("Destination address (128 bits)": 32),
)

=== Glossary

#deftbl(
  [Extension Header],
  [Additional headers used in IPv6 to provide optional information. These can define aspects like payload size, routing, or fragmentation.],
  [DHCPv6],
  [Dynamic Host Configuration Protocol for IPv6; this allows servers to assign IPv6 addresses dynamically from a pool, similar to DHCP for IPv4.],
  [NAT64],
  [Network Address Translation from IPv6 to IPv4 and vice versa; it facilitates communication between IPv6 and IPv4 networks.],
  [Neighbor Discovery \
    Protocol *(NDP)*],
  [A protocol in IPv6 for discovering other network nodes, determining their link-layer addresses, and ensuring that addresses are valid and reachable.],
  [Internet Control Message \
    Protocol *(ICMPv6)*],
  [A crucial part of IPv6 that handles error messages and operational queries, with an expanded role compared to ICMP in IPv4.],
  [MTU],
  [Maximum Transmission Unit; the size of the largest packet that can be sent in a single frame over a network medium. IPv6 can handle larger MTUs compared to IPv4. Default is 1500b],
  [Jumbo frame],
  [MTU of 9000b],
  [Multicast Listener Discovery *(MLD)*],
  [IPv6 multicast routers can use MLD to discover multicast listeners on a directly attached link.],
  [Path MTU Discovery *(PMTUD)*],
  [Protocol for determining the Maximum Transmission Unit (MTU) size on the network path between two hosts, usually with the goal of avoiding IP fragmentation.],
)

=== Special addresses

#deftbl(
  [Link-local Address],
  [_FE80::/10_ Used for local communication between devices on the same network segment.],
  [Global Unicast Address],
  [_2000::/3_ A globally routable address, these addresses are equivalent to public IPv4 addresses and can be reached over the internet.],
  [Unique Local Address *(ULA)*],
  [_FC00::/7_ An address for local communication that is not routable on the global internet, similar to private addresses in IPv4.],
  [Multicast Address],
  [_FF00::/8_ An address that enables a single packet to be sent to multiple destinations simultaneously.],
  [Anycast Address],
  [An address assigned to multiple interfaces, where a packet sent to an anycast address is routed to the nearest (in terms of routing distance) interface.],
  [Reserved Address],
  [Certain ranges in IPv6 are reserved for future use or specific functions. For example, addresses starting with _::/128_ are reserved for unspecified addresses.],
  [Documentation Address],
  [_2001:DB8::/32_ Designated specifically for use in documentation and examples, ensuring it does not conflict with real-world addresses.],
  [Link-local Multicast Address],
  [_FF02::/16_ Part of the link-local address range; it enables devices to communicate within a local network without requiring an external routing address.],
)

#table(
  columns: (1fr, 1fr, 1fr),
  table.header([Addresses], [Range], [Scope]),
  [Unspecified], [::/128], [n/a],
  [Loopback], [::1], [Host],
  [IPv4-Embedded], [64:ff9b::/96], [n/a],
  [Discard-Only], [100::/64], [n/a],
  [Link-Local], [fe80::/10], [Link],
  [Global Unicast], [2000::/3], [Global],
  [Unique Local (ULA)], [fc00::/7], [Global],
  [Multicast], [ff00::/8], [Variable],
)

==== Multicast

#deftbl(
  [ff02::1],
  [All nodes, within scope 2 (link-local).],
  [ff02::2],
  [All routers, within scope 2 (link-local).],
  [ff02::1:ffxx:xxxx],
  [The IPv6 node joins a solicited multicast address group from all the interfaces where unicast and anycast addresses are configured. Its scope is the link-local.],
)

==== DHCPv6

#deftbl(
  [ff02::1:2],
  [A link-scoped multicast address used by a client to communicate with neighboring (i.e., on-link) relay agents and servers. All servers and relay agents are members of this multicast group.],
  [ff05::1:3],
  [A site-scoped multicast address used by a relay agent to communicate with servers, either because the relay agent wants to send messages to all servers or because it does not know the unicast address of the servers.],
)

==== IPv6 Extension Headers currently defined

#deftbl(
  [Routing],
  [
    Used by an IPv6 source to list one or more intermediate nodes to be "visited" on the way to a packet’s destination. There are different types of routing headers defined for different uses.
  ],
  [Fragmentation],
  [
    Used by an IPv6 source to send a packet larger than would fit in the path MTU to its destination.
  ],
  [Authentication],
  [
    Used by IPsec to provide security services like integrity and data origin authentication to IPv6 traffic.
  ],
  [Encapsulating \ Security Payload],
  [Used by IPsec to provide security services like confidentiality and/or integrity to IPv6 packets.
  ],
  [Hop-by-Hop Option],
  [ Used to carry optional information that may be examined and processed by every node along a packet's delivery path. ],
  [Destination Options],
  [Optional information to be examined by the destination node],
)

=== Neighbor Discovery Protocol (NDP)

==== Host - Router Discovery Functions

#deftbl(
  [Router discovery],
  [Hosts can locate routers residing on attached links.],
  [Prefix discovery],
  [Hosts can discover address prefixes that are on-link for attached links.],
  [Parameter discovery],
  [Hosts can find parameters (e.g., MTU).],
  [Address autoconfiguration],
  [Stateless configuration of addresses of network interfaces.],
  [Redirect],
  [Provide a better next-hop route for certain destinations.],
)

==== Host - Host Communication Functions

#deftbl(
  [Address resolution],
  [Mapping between IP addresses and link-layer addresses. This is equivalent to ARP for IPv4. This function allows to resolve the link-layer address of another node in the link when only the IPv6 address of that node is known.],
  [Next-hop determination],
  [Hosts can find next-hop routers for a destination.],
  [Neighbor unreachability\ detection (NUD)],
  [Determine that a neighbor is no longer reachable on the link.],
  [Duplicate address\ detection (DAD)],
  [Nodes can check whether an address is already in use.],
)

==== Packet types

#table(
  columns: (auto, auto, auto),
  table.header([Name], [Type], [Description]),
  [Router Solicitation *(RS)*], [133], [To locate routers on an attached link.],

  [Router Advertisement *(RA)*],
  [134],
  [Used by routers to advertise their presence periodically or in response to a RS message.],

  [Neighbor Solicitation *(NS)*],
  [135],
  [To find the MAC-address of the neighbor or to check if the neighbor is still reachable.],

  [Neighbor Advertisement *(NA)*],
  [136],
  [To respond to a Neighbor Solicitation message.],

  [Redirect],
  [137],
  [To point the host to a better first hop router for a destination.],
)

=== Stateless Address Autoconfiguration (SLAAC)

A method for automatically configuring IPv6 addresses without a DHCP server, relying on local network information. \

==== Autoconfigure link-local address

Mac address: *70:07:12:34:56:78*
+ Flip *7th* bit: 7#text([2], weight: "bold"):07:12:34:56:78. If it is "0", the address is locally administered and if it is "1", the address is globally unique.
+ Insert *FFFE* in the middle: 7207:12#text([FF:FE], weight: "bold")34:5678
+ Combine with link-local prefix: #text([FE80::], weight: "bold")7207:12FF:FE34:5678
New address: *FE80::7207:12FF:FE34:5678*

==== Perform Duplicate Address Detection (DAD)

To make sure that the address is actually unique in the local segment. \
Upon configuring an IPv6 address, every node joins a *multicast group* identified by the address _FF02::1:FFxx:xxxx_ where xx:xxxx are the *last 6 hexadecimal values* in the IPv6 unicast address, eg. FF02::1:FF#text([34:5678], weight: "bold") \
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

#deftbl(
  [A],
  [Host can perform SLAAC to generate its own IPv6 address based on the prefix(es) contained in the RA message.],
  [O],
  [Host can fetch additional options from the DHCPv6. The DHCPv6 does not provide IPv6 addresses in this case.],
  [M],
  [Host will get its IP address and additional options from a DHCPv6 server.],
  [L],
  [The prefix shared in the RA is reachable on the link.],
)

== IPv4

#frame(
  (
    Version: (desc: "Version of IP Protocol (always 4)", size: 4),
    IHL: (desc: "Internet Header Length (in 32bit words. min 5)", size: 4),
    DSCP: (desc: "Differentiated Services Code Point", size: 6),
    ECN: (desc: "Explicit Congestion Notification", size: 2),
    "Total Length": (desc: "Header + Data in bytes. max is 65'535", size: 16),
  ),
  (
    Identification: (
      desc: "Used to uniquely identify each packet sent from a source host. It helps in reassembling fragmented packets at the destination.",
      size: 16,
    ),
    RS: (desc: "Reserved (must be zero)", size: 1),
    DF: (desc: "Don't Fragment", size: 1),
    MF: (desc: "More Fragments", size: 1),
    "Fragment Offset": (
      desc: "Position of the fragment. Must be multiplied by 8 to extrapolate the position of the fragment inside of a packet.",
      size: 13,
    ),
  ),
  (
    "Time to Live": (desc: "Hop limit", size: 8),
    "Protocol": (desc: "Protocol of data portion", size: 8),
    "Header Checksum": 16,
  ),
  ("Source IP Address": 32),
  ("Destination IP Address": 32),
  (
    "Options (if IHL > 5)": (
      desc: "Variable in length. Can specify timestamps, record route or other settings",
      size: 32,
    ),
  ),
  ("Data": (desc: "Variable in length", size: 32)),
)

=== Network classes (private nets)

#deftbl(
  [A],
  [*10.0.0.0*    - 10.255.255.255  (10_/8_ prefix)],
  [B],
  [*172.16.0.0*  - 172.31.255.255  (172.16_/12_ prefix)],
  [C],
  [*192.168.0.0* - 192.168.255.255 (192.168_/16_ prefix)],
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

=== Control plane

Includes functions and processes that determine which path to use to send the packet or frame. The control plane is responsible for populating the routing table, drawing network topology, forwarding table, and hence enabling the data plane functions. This means here the router makes its decision.

- Network-wide logic
- Determines how datagram is routed among routers along end-to-end path from source to destination host

=== Data plane

Includes functions and processes that forward packets/frames from one interface to another based on control plane logic. Routing table, forwarding table and the routing logic constitute the data plane function. Data plane packet goes through the router and incoming and outgoing of frames are done based on control plane logic.

- Local, per-router function
- Determines how datagram arriving on router input port is forwarded to router output port

=== Dynamic

==== Dijkstra's algorithm (Link State)

#let re = (f, t, c) => edge(
  f,
  t,
  "-|>",
  text(fill: colors.red)[#c],
  label-side: center,
  stroke: colors.red,
)
#[
  #let diagram = diagram.with(
    node-shape: circle,
    spacing: (3em, 0.5em),
  )
  #grid(
    columns: (1fr, 1fr),
    diagram(
      node((1, 2), "u", name: <u>),
      node((2, 1), "v", name: <v>),
      node((3, 1), "w", name: <w>),
      node((2, 3), "x", name: <x>),
      node((3, 3), "y", name: <y>),
      node((4, 2), "z", name: <z>),
      edge(<u>, <v>, "-", [2]),
      edge(<u>, <x>, "-", [1]),
      edge(<u>, <w>, "-", [5], bend: 60deg),
      edge(<v>, <x>, "-", [2]),
      edge(<v>, <w>, "-", [3]),
      edge(<x>, <y>, "-", [1]),
      edge(<x>, <w>, "-", [3]),
      edge(<y>, <w>, "-", [1]),
      edge(<y>, <z>, "-", [2]),
      edge(<w>, <z>, "-", [5]),
    ),
    diagram(
      node((1, 2), "u", name: <u>),
      node((2, 1), "v", name: <v>),
      node((3, 1), "w", name: <w>),
      node((2, 3), "x", name: <x>),
      node((3, 3), "y", name: <y>),
      node((4, 2), "z", name: <z>),
      re(<u>, <v>, [2]),
      re(<u>, <x>, [1]),
      edge(<u>, <w>, "-", [5], bend: 60deg),
      edge(<v>, <x>, "-", [2]),
      edge(<v>, <w>, "-", [3]),
      re(<x>, <y>, [1]),
      edge(<x>, <w>, "-", [3]),
      re(<y>, <w>, [1]),
      re(<y>, <z>, [2]),
      edge(<w>, <z>, "-", [5]),
    ),
  )
]
#table(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.header(
    [Step],
    [N'],
    [D(v),p(v)],
    [D(w),p(w)],
    [D(x),p(x)],
    [D(y),p(y)],
    [D(z),p(z)],
  ),
  [0], [u], [2,u], [5,u], [1,u], [$infinity$], [$infinity$],
  [1], [ux], [2,u], [4,x], [], [2,x], [$infinity$],
  [2], [uxy], [2,u], [3,y], [], [], [4,y],
  [3], [uxyv], [], [3,y], [], [], [4,y],
  [4], [uxyvw], [], [], [], [], [4,y],
  [5], [uxyvwz], [], [], [], [], [4,y],
)

==== OSPF (Open Shortest Path First)

- Each router floods OSPF link-state advertisements (directly over IP rather than using TCP/UDP) to all other routers in entire AS
- Multiple link costs metrics possible: bandwidth, delay
- Each router has full topology, uses Dijkstra’s algorithm to compute forwarding table

#image("./img/ospf.png")

==== RIP (Routing Information Protocol)

Not used anymore, uses distance vector algorithm to calculate shortest route.

= Data Link Layer (2)

Functions:
- Error detection
- Flow control
- Addressing

== Ethernet

Ethernet specifies and implements encoding and decoding schemes that enable frame bits to be carried as signals across both copper and fiber cables. Ethernet separates the functions of the data link layer into two sublayers: Logical Link Control and Media Access Control.

#table(
  columns: (1fr, 1fr),
  table.header([Logical Link Control (LLC)], [Media Access Control  (MAC)]),
  [ Handles communication between the network layer and the MAC sublayer. Provides a way to identify the protocol that is passed from the data link layer to the network layer. ],
  [ Data encapsulation: Includes frame assembly before transmission, frame parsing upon reception of a frame, data link layer MAC addressing and error detection. ],
)

=== Carrier Sense Multiple Access with Collision Detection (CSMA/CD)

Defines how the Ethernet logical bus is accessed. It is in effect within a collision domain and if a device’s network interface card (NIC) is operating in half-duplex mode. It helps prevent collisions and defines how to act when a collision does occur.

- _Carrier Sense_: Listen to the medium
- _Multiple Access_: Sending if medium is free, else waiting for a random time and try again
- _Collision_: The amplitude of the signal increases beacuse a collision occurs.
- _Collision Detection / Backoff algorithm_: The nodes stop transmitting for a random period of time, which is different for each device.

After 16 tries, the host gives up the transmission attempt and discards the frame. The network is overloaded or
broken.

==== What happens when a collision occurs?

- A jam signal informs all devices that a collision occurred.
- The collision invokes a random backoff algorithm.
- Each device on the Ethernet segment stops transmitting until their backoff timers expire.
- All hosts have equal priority to transmit after the timers have expired.

==== Collision domain vs broadcast domain

#align(center, image(width: 60%, "./img/collision-domain.png"))

=== Half-duplex vs Full-duplex

Full-duplex requires point-to-point connection where only two nodes are present. The data is sent on a different set of wires
than the received data, so no collisions will occur. When a NIC detects that it can operate in full-duplex mode,
CSMA/CD is disabled. Half-duplex needs CSMA/CD for collision detection.

=== Ethernet II Frame

#custom-frame(
  columns: (1fr, 1fr, 1fr, 4fr, 1fr),
  table.cell(colspan: 5, "<-- 64B (1518 Bytes) -->"),
  [DA 6B],
  [SA 6B],
  [Type 2B],
  table.cell(fill: colors.blue, [DATA (MAC SDU) 0 (+64 padding) ... 1500B]),
  [FCS 4B],
)

#deftbl(
  [DA],
  [Destination Address],
  [SA],
  [Source Address],
  [Type],
  [EtherType protocol, eg. IPv4/ARP],
  [FCS],
  [Frame Check Sequence],
)

Most common type in use today. Also called the DIX frame.

MAC PDU must be at least 64B to guarantee that all collisions can be detected. If it's smaller, the frame must be filled with Padding Bytes.

=== IEEE 802.3 Frame

#custom-frame(
  columns: (1fr, 1fr, 1fr, 1fr, 3fr, 1fr),
  table.cell(colspan: 6, "<-- 64B (1518 Bytes) -->"),
  [DA 6B],
  [SA 6B],
  [Length 2B],
  table.cell(fill: colors.blue, [LLC 802.2]),
  table.cell(fill: colors.blue, [LLC SDU]),
  [FCS 4B],
)

=== Frame Check Sequence (FCS)

- The sender applies a math formula to the frame before sending it, storing the result in the FCS field.
- The receiver applies the same math formula to the received frame and compares with the sender’s result.
- If the results are the same, the frame did not change. If the results are different, an error occurred, and the receiver discards the frame. The Ethernet device does not attempt to recover the lost frame.

== Error detection

#deftbl(
  [EDC (Error Detection Code)],
  [A generic term for various methods used to identify errors in transmitted data.	Various data communication protocols],
  [CRC (Cyclic Redundancy Check)],
  [A specific type of EDC that uses polynomial division to detect changes to raw data.],
)

== MAC-Address

#frame(
  (
    "OUI": (
      desc: "It is assigned by the Institute of Electrical and Electronics Engineers (IEEE) to specific manufacturers or organizations. The OUI uniquely identifies the organization that produced the network interface.",
      size: 24,
      name: [Organizationally Unique\ Identifier (OUI)],
    ),
    "NIC specific": (
      desc: "This portion ensures that each device produced by the same organization has a unique MAC address.",
      size: 24,
    ),
  ),
)

7th bit: Globally unique (0) or locally administered (1)

8th bit: Unicast (0) or multicast (1)

== Address Resolution Protocol (ARP)

Maps network addresses to data link layer addresses / resolves IPv4 addresses to MAC addresses. Entries in the ARP table are time stamped and can time out.

Entries are added by monitoring the traffic and adding source IP and MAC addresses of the incoming packets to the table. If no entry is found inside of the ARP table, then the node launches an ARP discovery process by sending an ARP broadcast request and receiving an ARP reply from the requested MAC addresses' host. When a node receives a packet with a destination IP address where no cached entry for the MAC address can be found, the encapsulation of the IPv4 packet fails and the packet gets dropped.

IPv6 does not need ARP because it uses the Neighnor Discovery Protocol (NDP).

#grid(
  columns: (2fr, 1fr),
  image("./img/arp.png"),
  [
    + PC C sends a packet to 10.0.0.4, PC D responds.
      - SW02 sends broadcast
      - all switches receive C's address
      - SW02 and SW03 receive D's address from the reply
    + PC A sends a frame to dd:dd:dd:dd:dd:dd, PC D responds.
      - SW01 sends broadcast
      - SW02 & SW03 alread know D's address
      - SW01-SW03 receive A's address
    + PC B sends an ICMP ping to 10.0.0.4
      - PC B sends ARP request to find D's  MAC address
      - all switches receive B's address
  ],
)

=== Discovery

+ PC A sends a broadcast: "Who has the IP 10.10.10.30?"
+ The ARP Request is flooded
+ The PC with the sought IP sends his ARP Reply "I have the IP, here is my MAC Address". This is sent as a unicast because the Switch already knows PC A.
+ Now the PC A knows the MAC address of 10.10.10.30 and can send its Packet.

=== Spoofing

ARP has no validation if the sender of a frame is correct. ARP spoofing, also called ARP poisoning, refers to the method of inserting the wrong MAC address into ARP requests and responses by the node. An attacker can lead sent frames to the wrong destination and has the ability to read the traffic (MITM attack). Configuring static ARP entries is one way to prevent ARP spoofing.

== Switch

- All devices connected to the switch ports form a _broadcast domain_
- All ports are full-duplex

=== Flooding

When a switch gets a data packet, and it did not know the DA, it
floods the information to all ports but the one where it received
the data. (Unicast flooding)

=== Filtering

When a switch gets a data packet, and already knows that the DA
is on the same port as the SA, it filters the information and does
not flood it, because the other switches do not need to know. This
reduces traffic.

=== Forwarding

If the destination MAC address comes from another port within the
switch, then the frame is sent to the identified port for transmission.

=== EtherChannel \= Link Aggregation Group (LAG)

EtherChannel is a technology used in networking to group several physical Ethernet links into a single logical link. This approach increases bandwidth and provides redundancy.

=== Link Aggregation Control Protocol (LACP)

IEEE specification (802.3ad) open-standard protocol for EtherChannel Configurations. It dynamically adds and manages ports in the EtherChannel.

==== Load balancing

The hashes created from source or destination IP addresses determine which link in the EtherChannel will carry the traffic.

#deftbl(
  [src-ip],
  [Use when: Many devices with different IPs send to one device with a single IP address],
  [dst-ip],
  [Use when: A device with a single IP sends to many devices with different IP addresses],
)

== VLAN

LAN: all devices in the same broadcast domain

VLAN: Virtual separation of LAN on a switch

Reasons for using VLANs:
- To reduce CPU overhead on each device by reducing the number of devices that receive each broadcast frame
- To reduce security risks by reducing the number of hosts that receive copies of frames that the switches flood (broadcasts, multicasts, and unknown unicasts)
- To improve security for hosts that send sensitive data by keeping those hosts on a sepa- rate VLAN
- To create more flexible designs that group users by department, or by groups that work together, instead of by physical location
- To solve problems more quickly, because the failure domain for many problems is the same set of devices as those in the same broadcast domain
- To reduce the workload for the Spanning Tree Protocol (STP) by limiting a VLAN to a single access switch

=== Trunking

With _trunking_, only a single cable is needed to carry traffic for all VLANs. VLAN trunking works by applying _VLAN tagging_, where the sending switch adds an extra header to each frame before sending it across the trunk link. This trunking header contains a VLAN Identifier (VLAN ID), allowing the receiving switch to determine the VLAN to which each frame belongs. Switch ports that are assigned to a single VLAN and carry traffic for only that VLAN are referred to as _access ports_. Ports that carry traffic for multiple VLANs using VLAN tagging are called _trunk ports_.

=== 802.1Q

The standard of how to tag an ethernet frame in a trunk is defined in IEEE 802.1Q. 802.1Q inserts an extra 4 byte 802.1Q VLAN header into the original frame’s Ethernet header.

=== Inter-VLAN Routing

==== Attaching a Router

A router can be added to a switch using multiple VLANs. The cable from the switch to the router gets configured as a trunk. The router then can simply perform its usual routing logic between the subnets. This concept is called _Router-on-a-Stick_.

==== Using a Layer 3 Switch

With the use of a switch with layer 3 capabilities, the need for a separate router is omitted, as the switch brings the ability for routing by itself. Routing can be turned on that switch and packets between the VLANs get routed.

=== Spanning Tree Protocol (STP)

#link(
  "https://www.cisco.com/c/en/us/td/docs/routers/access/3200/software/wireless/SpanningTree.html",
  "cisco docs",
)

Prevents loops in the network (eg. broadcast).

#deftbl(
  [Root device],
  [Bridge on the network that serves as a central point in the spanning tree],
  [Root port],
  [Port on each device that provides the most efficient path to the device],
  [Designated port],
  [Lowest path cost when forwarding packets from that LAN to the spanning-tree root],
  [Disabled port],
  [Port is disabled to prevent loops],
  [BPDU],
  [
    Bridge Protocol Data Unit. Destination address is multicast: 01:80:c2:00:00:00

    Types:
    - Hello / configuration BPDU. Sent by the root bridge
    - Topology Change Notification (TCN). Sent by a different switch to the root
  ],
  [CAM table],
  [MAC address table, maps MAC addresses to ports. Entries have an aging limit],
)

#image("./img/stp.png")

==== Procedure

When the bridges in a network are powered up, each bridge functions as the STP root. The bridges send configuration BPDUs and compute the spanning-tree topology.

When a bridge receives a configuration BPDU that contains superior information (lower bridge ID, lower path cost, and so forth), it stores the information for that port. If this BPDU is received on the root port of the bridge, the bridge also forwards it with an updated message to all attached LANs for which it is the designated bridge.

If a bridge receives a configuration BPDU that contains inferior information to that currently stored for that port, it discards the BPDU.

==== Determining bridge priority

+ Lowest root bridge ID (BID) – Determines the root bridge.
+ Lowest cost to the root bridge – Favors the upstream switch with the least cost to root
+ Lowest sender bridge ID – Serves as a tiebreaker if multiple upstream switches have equal cost to root
+ Lowest sender port ID – Serves as a tiebreaker if a switch has multiple (non-EtherChannel) links to a single upstream switch, where:
  - Bridge ID = priority (4 bits) + locally assigned system ID extension (12 bits) + ID [MAC address] (48 bits); the default bridge priority is 32,768, and
  - Port ID = priority (4 bits) + ID (Interface number) (12 bits); the default port priority is 128.

==== Manual calculation steps

+ Identify the Root Bridge with the lowest BID (only one per network)
+ Identify link costs (per link)
+ Select root ports (1 per switch) with the lowest total cost to the Root Bridge
+ Select designated ports (1 per link)
+ Identify blocked ports (1 per redundant link)

==== Port states

#deftbl(
  term: "State",
  [Disabled],
  [Administratively disabled for various reasons. Does not participate in STP/PVST operation.],
  [Blocking],
  [After excluding disabled ports, the switch starts all ports in the blocking state. In this state, the port does not accept user frames. It accepts only BPDUs.],
  [Listening],
  [The first transitional state after the blocking state, in which the spanning tree determines that the interface should participate in frame forwarding],
  [Learning],
  [In this state, the switch builds the CAM table entries. The port accepts user frames but does not forward them. From the incoming frames, it learns the MAC addresses of the connected devices. It saves the learned MAC addresses in the CAM table.],
  [Forwarding],
  [Accepts and forwards user frames.],
)

==== Timers

#deftbl(
  term: "Timer",
  [hello interval (2s)],
  [The interval at which a bridge sends out configuration BPDUs.],
  [forward delay (15s)],
  [The time a port remains in the Listening and Learning states before transitioning to the Forwarding state.],
  [max age (20s)],
  [The maximum age of a received BPDU before it is considered stale.],
)

==== Topology change

+ Link goes down
+ Switch with changed link will send a BPDU of type *Topology Change Notification* (TCN) on its root port
+ Next switch in the hierarchy forwards the TCN to its root port and sends a configuration BPDU with the *Topology Change Acknowledgement* (TCA) flag set back to the previous bridge
+ As soon as root bridge receives TCN it sends a configuration BPDU with the TCA and *Topology Change* (TC) flags set
+ Root bridge continues to set TC flag on its configuration BPDUs for a duration of Max Age + Forward Delay (35s) and the other bridges forward them
+ As soon as a switch receives a BPDU with TC set, it shortens its MAC address aging timer to Forward Delay (15s)

=== Rapid Spanning Tree Protocol (RSTP)

RSTP provides significantly faster spanning tree convergence after a topology change, introducing new convergence behaviors and bridge port roles to accomplish this. While STP can take 30 to 50 seconds to respond to a topology change, RSTP is typically able to respond to changes within 3 \* hello times (default: 3 \* 2 seconds) or within a few milliseconds of a physical link failure.

== Wireless

Uses different MAC address.

#deftbl(
  [BSSID],
  [Every AP has a unique BSSID],
  [ESSID / SSID],
  [Every WLAN has an ESSID. Isn't unique.],
)

=== Channel bonding

Two or more adjacent channels within a given frequency band
are combined to increase throughput between two or more
wireless devices.

=== Carrier-Sense Multiple Access with Collision Avoidance (CSMA/CA)

#grid(
  columns: (auto, 1fr),
  diagram(
    spacing: (4em, 2em),

    node((0, 0), [Start], shape: pill, name: <s>),
    node((0, 1), [Assemble\ a Frame], shape: rect, name: <a>),
    edge(<s>, <a>, "-|>"),
    node((0, 2), [Is the\ Channel Idle?], shape: diamond, name: <ci>),
    edge(
      "l,d,d,d,r",
      shift: (-30pt, 0pt),
      "-|>",
      [YES\ Not using\ IEEE 802.11\ RTC/CTS\ Exchange],
    ),
    node((1, 2), [Wait for Random\ Backoff Time], shape: rect, name: <b>),
    edge(<ci>, <b>, "-|>", [NO]),
    edge(<a>, <ci>, "-|>"),
    edge(<b>, <a>, corner: left, shift: (0pt, -22pt), "-|>"),
    node((0, 3), [Transmit RTS], shape: rect, name: <tr>),
    edge(<ci>, <tr>, "-|>", [YES]),
    node((0, 4), [CTS\ Received?], shape: diamond, name: <cr>),
    edge(<tr>, <cr>, "-|>"),
    node((0, 5), [Transmit\ Application Data], shape: rect, name: <ta>),
    edge(<cr>, <ta>, "-|>", [YES]),
    edge(
      <cr>,
      <b>,
      corner: left,
      "-|>",
      [NO\ Using\ IEEE 802.11\ RTC/CTS\ Exchange],
    ),
    node((0, 6), [End], shape: pill, name: <e>),
    edge(<ta>, <e>, "-|>"),
  ),
  [
    In wireless, it is also possible to have collisions, because it is a
    shared medium.
    - Client sends an RTS (request to send) "Can I send for xy time?"
    - Access point answers with a CTS (clear to send), which all connected devices get. "Access Point XY is now sending for xy amount of time (minus the time for the RTS)"
    - Transmission
  ],
)

==== Hidden node

#grid(
  columns: (1fr, 2fr),
  image("./img/hidden-node.png"),
  [It is not possible to use CSMA/CD because we do not know if
    everyone receives everything. If there is a wall between to
    clients for example, the clients do not know if the other is
    sending at the same time.
  ],
)

==== Distributed Coordination Function (DCF)

Function which creates the backoff time for CSMA/CA. CTS, ACK and Block ACK (SIFS) have the highest priority and
the shortest backoff time. PIFS have a middle priority and DIFS the lowest.

==== Network Allocation Vector (NAV)

Listening Stations can mark the medium as busy with the Network Allocation Vector (NAV), while another station is
sending.

=== Frame

#custom-frame(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.cell(align: center, colspan: 9, "<-- 34-2346B -->"),
  "Frame ctrl (2B)",
  "Duration ID (2B)",
  "Addr. 1 (6B)",
  "Addr. 2 (6B)",
  "Addr. 3 (6B)",
  "Seq. ctrl (2B)",
  "Addr. 4 (6B)",
  "Data",
  "CRC (4B)",
)
==== Frame Control
#custom-frame(
  columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
  table.cell(align: center, colspan: 11, "<-- 2B (16b) -->"),
  "Protocol ver. (2b)",
  "Type (2b)",
  "SubType (4b)",
  "To DS (1b)",
  "From DS (1b)",
  "More Frag (1b)",
  "Retry (1b)",
  "Pwr Mgt (1b)",
  "More Data (1b)",
  "WEP (1b)",
  "Rsvd (1b)",
)
#deftbl(
  [To DS],
  [Whether the frame is being sent to the Distribution System],
  [From DS],
  [Whether the frame originated from the Distribution System],
)

=== Management features

Frame types:

#deftbl(
  [Probe Request],
  [ Frame sent by a client to discover available networks by querying nearby APs for their information.],
  [Probe Response],
  [ Frame sent by an AP in reply to a Probe Request, providing details about the AP, including its network name (SSID) and capabilities.],
  [Authentication\ Request/Response],
  [ Frame used in the initial setup process, where a client requests authentication from the AP before being allowed to access the network.],
  [Association Request],
  [ Frame sent by a client to a wireless access point (AP) requesting to join a specific network.],
  [Association Response],
  [ Frame sent by the AP in response to the Association Request, indicating whether the association was successful and providing parameters for the connection.],
  [Reassociation Request],
  [ Frame sent when a client moves from one AP to another within the same network, requesting to re-establish a connection.],
  [Reassociation Response],
  [ Frame sent by the new AP in response to the Reassociation Request, confirming the re-establishment of the connection.],
  [Timing Advertisement],
  [ Frame used in power-saving modes to inform clients about the timing of beacon frames, enabling better synchronization and energy efficiency.],
  [Beacon],
  [ Periodic frame broadcasted by an AP that provides information about the network, including the SSID, supported data rates, and security protocols.],
  [Disassociation],
  [ Frame sent by either the client or the AP to terminate an association, indicating that the client is leaving the network or the connection is lost.],
  [Deauthentication],
  [ Frame used to terminate the authentication between the client and the AP, often when the client disconnects or is forcibly removed from the network.],
)

==== Association / Reassociation

#grid(
  columns: (auto, 1fr),
  gutter: 5em,
  chronos.diagram({
    _par("Host")
    _par("AP")

    _seq("Host", "AP", comment: "Probe request")
    _seq("AP", "Host", dashed: true, comment: "Probe response")
    _seq("Host", "AP", comment: "Authentication request")
    _seq("AP", "Host", dashed: true, comment: "Authentication response")
    _seq("Host", "AP", comment: "Association request")
    _seq("AP", "Host", dashed: true, comment: "Association response")
    _seq("Host", "AP", comment: "Data", start-tip: ">", end-tip: ">")
  }),
  [
    How does a client connect to an AP?
    + Client sends Probe
    + AP Sends Probe Response
    + Client selects best AP
    + Client sends auth request to selected AP
    + AP confirms authentication and registers client
    + Client sends association request to selected AP
    + AP confirms association and registers client
  ],
)

=== Roaming

#grid(
  columns: (auto, 1fr),
  chronos.diagram({
    _par("Old AP", color: colors.white)
    _par("Host")
    _par("New AP")

    _seq("Host", "Old AP", comment: "Data", start-tip: ">", end-tip: ">")

    _seq("Host", "New AP", comment: "Probe request")
    _seq("New AP", "Host", dashed: true, comment: "Probe response")

    _seq("Host", "Old AP", comment: "Data", start-tip: ">", end-tip: ">")
    _seq("Host", "Old AP", dashed: true, comment: "Deauthentication")

    _seq("Host", "New AP", comment: "Authentication request")
    _seq("New AP", "Host", dashed: true, comment: "Authentication response")
    _seq("Host", "New AP", comment: "Reassociation request")
    _seq("New AP", "Host", dashed: true, comment: "Reassociation response")

    _seq("Host", "Old AP", dashed: true, comment: "Disassociation")

    _seq("Old AP", "New AP", comment: "Buffered data")

    _seq("Host", "New AP", comment: "Data", start-tip: ">", end-tip: ">")
  }),
  [
    Switching to another AP with better signal strength.
    A client is connected to an AP. If there is an AP that is at least say 10dB better and the signal strength of the current
    AP is below a limit of  say 75dB (handoff threshold), a handover occurs.

    + Station sends probe
    + AP sends Probe response
    + Client selects best AP
    + Either old AP or client authenticate to new AP
    + Client sends a reassociation request to the new AP
    + New AP sends a reassociation response
    + Client sends a disassociation request to the old AP
    + The old AP sends the unacknowledged data to the new AP, using the inter Access Point Protocol (802.11f)

    Roaming usually takes (too much) time because of the many steps listed above.
    There are ways to improve roaming, for example with direct handover from AP to AP without re-authentication
    (802.11r).
  ],
)

==== Handoff Thresholds

Parameters that determine when a device should switch from one access point to another during movement. These might include:

#deftbl(
  [Signal Strength Threshold],
  [ Sets a minimum signal level below which the device should consider roaming to another AP.],
  [Quality of Service (QoS) Metrics],
  [ Based on the performance characteristics, like latency or packet loss, thresholds can dictate when to switch.],
)

= Physical Layer (1)


Responsibilities
- Representing bits as physical signals (electrical voltage, light pulses, radio waves)
- Defining cables, connectors, modulation methods, and wireless frequencies
- Synchronization of transmitter and receiver
- Data rates and physical medium characteristics

== Encodings

Encoding converts the stream of bits into a format recognizable by the next device in the network path.

#grid(
  columns: (1fr, 2fr),
  [
    === Manchester encoding

    - Self-clocking
    - 1 = Falling
    - 0 = Rising
    - Requires twice as much bandwitdth as binary encoding
  ],
  image("./img/manchester.png"),

  [
    === RZ (Return-to-Zero)

    - Self-clocking
    - Refinement of NRZ

  ],
  image("./img/rz.png"),

  [
    === NRZ (Non-Return-to-Zero)

    - Not self-clocking
  ],
  image("./img/nrz.png"),
)

=== 8b/10b (Clock recovery)

Maps 8-bit words to 10-bit symbols – prevents too many zeros or ones in a row (relevant for NRZ).

== Power and dB

#deftbl(
  [dB],
  [decibel],
  [dBm],
  [decibel ratio to 1mW],
  [dBi],
  [antenna gain compared to isotropic radiator],
  [RSSI],
  [Received signal strength indication],
  [SNR],
  [Signal to Noise Ratio],
  [Receiver Sensitivity],
  [up to which level signals can be received successfully],
)

$
  "decibels" = 10 dot log_10("milliwatts") \
  "milliwatts" = 10^("decibels"/10)
$

=== Law of 3s

- A value of 3 dB means that the power value of interest is double the reference value
- A value of −3 dB means the power value of interest is half the reference

=== Law of 10s

- A value of 10 dB means that the power value of interest is 10 times the reference value
- A value of −10 dB means the power value of interest is 1/10 of the reference

== Modulation

Altering the carrier signal.

== Fiber media

#table(
  columns: (1fr, 1fr),
  table.header([Single-Mode], [Multimode]),
  [Very small core], [Larger core],
  [Expensive lasers], [Less expensive LEDs],
  [Long-distance applications ($=>$ more susceptible to chromatic dispersion)],
  [up to 10Gbps over 500 meters],

  [], [LEDs transmit at different angles],
)

#grid(
  columns: (1fr, 1fr),
  [
    === Eye Diagram

    - An eye diagram results from superimposing the "0"s and "1"s of a high-speed digital data stream.
    - An eye diagram shows a relative performance of the signal
    - For a good transmission system, the eye opening should be as wide and open as possible
    - Horizontal shift is called jitter, which can be caused by imprecise clocks
  ],
  image("./img/eye-diagram.png"),
)

=== Attenuation

- Absorption by the fiber material
- Scattering of the light from the fiber

#deftbl(
  [Microbends],
  [Caused by small distortions of the fiber in manufacturing],
  [Macrobends],
  [Caused by wrapping fiber around a corner with too small a bending radius],
  [Back reflections],
  [Caused by reflections at fiber ends, like connectors],
  [Fiber splices],
  [Caused by poor alignment or dirt],
  [Mechanical connections],
  [Physical gaps between fibers],
)

=== Dispersion

#deftbl(
  [Chromatic Dispersion],
  [
    - Different wavelengths travel at different speeds
    - Causes spreading of the light pulse
  ],
  [Polarization Mode Dispersion (PMD)],
  [
    - Single-mode fiber supports two polarization states
    - Fast and slow axes have different group velocities
    - Causes spreading of the light pulse
  ],
)

=== Regeneration

Fixes the dispersion.

#grid(
  columns: (2fr, 1fr),
  deftbl(
    [Re-amplifying],
    [Makes the analog signal stronger (i.e. makes the light brighter)],
    [Reshaping],
    [Restores the original pulse shape that is used to distinguish 1’s and 0’s.],
    [Retiming],
    [Restores the original timing between the pulses. Usually involves an Optical-Electric- Optical (O-E-O) conversion.],
  ),
  image("./img/regeneration.png"),
)

== Frequency

#grid(
  columns: (2fr, 1fr),
  deftbl(
    [Hertz (Hz)],
    [Number of cycles per second],
    [Bandwidth],
    [Width of frequency space required within the band],
    [Wavelength],
    [Measure of the physical distance that a wave travels over on cycle. Increases as the frequency decreases],
  ),
  image("./img/frequency.png"),
)

== Calculations

=== Speed of Signals

In fiber glass, signals travel about 2/3 of the speed of light (200’000km/s).

The Time a Signal needs is calculated as follows:
$ T(s) = "Length of cable (km)"/"Speed of signal (km/s)" $

=== Optical budget

Transmission power - Receiver sensitivity

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
